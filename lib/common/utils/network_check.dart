
import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkCheck {
  Future<bool> isOnline();
}
@LazySingleton(as: NetworkCheck)
class NetworkCheckImpl implements NetworkCheck {
  final Connectivity connectivity;

  NetworkCheckImpl({required this.connectivity});

  @override
  Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      // Connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // Connected to a wifi network.
      return true;
    }
    return false;
  }
}
