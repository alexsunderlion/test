import 'package:injectable/injectable.dart';

abstract class AppConfig {
  String get baseUrl;

  String get apiKey;

  bool get logHttpRequests;

  int get connectTimeout;

  int get receiveTimeout;
}

@Singleton(as: AppConfig)
class AppConfigImpl extends AppConfig {
  @override
  final String baseUrl = 'http://ws.audioscrobbler.com';
  @override
  final String apiKey = 'a35699f435445486aec22d7a19e652bf';

  @override
  final int connectTimeout = 20000;

  @override
  final int receiveTimeout = 20000;

  @override
  final bool logHttpRequests = true;
}
