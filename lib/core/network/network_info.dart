import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected {
    return connectivity.hasConnection;
  }
}
