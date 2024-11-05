import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetServices {
  Future<bool> isInternetAvailable() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
