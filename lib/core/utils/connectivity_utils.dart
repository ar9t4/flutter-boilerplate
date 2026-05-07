import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static Future<bool> isConnected() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet);
    } catch (e) {
      return false;
    }
  }
}
