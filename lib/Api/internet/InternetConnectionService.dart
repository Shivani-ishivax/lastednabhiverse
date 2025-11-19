import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
class InternetConnectionService {
  static final InternetConnectionService _instance = InternetConnectionService._internal();

  factory InternetConnectionService() => _instance;

  InternetConnectionService._internal();

  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _internetChecker = InternetConnectionChecker.createInstance();
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();

  Stream<bool> get onConnectionChange => _connectionChangeController.stream;

  void initialize() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      bool hasInternet = await _internetChecker.hasConnection;
      _connectionChangeController.add(hasInternet);
    });
  }

  Future<bool> checkConnection() async {
    return await _internetChecker.hasConnection;
  }

  void dispose() {
    _connectionChangeController.close();
  }
}