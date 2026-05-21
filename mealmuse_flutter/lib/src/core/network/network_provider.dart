import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum ConnectivityStatus { isConnected, isDisconnected }

final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  return Connectivity().onConnectivityChanged.asyncMap((results) async {
    // ConnectivityResult can be a list in newer versions
    final result = results.first;
    if (result == ConnectivityResult.none) {
      return ConnectivityStatus.isDisconnected;
    } else {
      // Double check actual internet access
      bool hasAccess = await InternetConnection().hasInternetAccess;
      return hasAccess
          ? ConnectivityStatus.isConnected
          : ConnectivityStatus.isDisconnected;
    }
  });
});
