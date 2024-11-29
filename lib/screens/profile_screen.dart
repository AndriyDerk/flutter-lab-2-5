import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../repository/local_user_repository.dart';
import '../widgets/dialogs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repository = LocalUserRepository();
  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectivityStream;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _checkInitialConnection();
    _listenToConnectivityChanges();
  }

  void _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    print('Initial connection: $result');
    setState(() {
      _isConnected = result != ConnectivityResult.none;
    });
    if (!_isConnected) {
      _showNetworkWarning();
    }
  }

  void _listenToConnectivityChanges() {
    _connectivityStream.listen((ConnectivityResult result) {
      print('Connectivity change detected: $result');
      final wasConnected = _isConnected;
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
      if (_isConnected != wasConnected) {
        if (!_isConnected) {
          _showNetworkWarning();
        } else {
          showInfoDialog(context, 'You are back online.');
        }
      }
    });
  }

  void _showNetworkWarning() {
    showInfoDialog(
        context, 'You are offline. Some features may be unavailable.');
  }

  void _logout() {
    showConfirmDialog(
      context,
      'Do you really want to log out?',
      () async {
        await _repository.clearSession();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: _isConnected
            ? Text('Welcome to the app!', style: TextStyle(fontSize: 18))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No internet connection.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  Text('Reconnect to access full functionality.'),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
