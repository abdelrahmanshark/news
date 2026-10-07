import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  /// Returns true when the device has any network connection.
  Future<bool> isOnline() async {
    final List<ConnectivityResult> results = await _connectivity
        .checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }
}
