import 'package:clubforce/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Common api client for all requests
abstract class ApiClientBase {
  final Dio dio;
  final AppConfig appConfig;

  ApiClientBase({
    required this.dio,
    required this.appConfig,
  }) {
    dio
      ..options.connectTimeout = Duration(milliseconds: appConfig.connectTimeout)
      ..options.receiveTimeout = Duration(milliseconds: appConfig.receiveTimeout);

    if (appConfig.logHttpRequests) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          maxWidth: 120,
        ),
      );
    }
  }

  Future<void> preCheck() async {
    //To have pre check operation like verify the access token valid
  }

  final _defaultOptions = Options(
    validateStatus: (status) {
      return status! < 501;
    },
  );

  /// Execute http get request
  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    await preCheck();
    return await dio.get<dynamic>(
      path,
      options: _defaultOptions,
      queryParameters: queryParameters,
    );
  }

  /// Execute http post request
  Future<Response<dynamic>> post(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    await preCheck();
    final response = await dio.post<dynamic>(
      path,
      data: data,
      options: _defaultOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  /// Execute http put request
  Future<Response<dynamic>> put(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    await preCheck();
    final response = await dio.put<dynamic>(
      path,
      data: data,
      options: _defaultOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  /// Execute http patch request
  Future<Response<dynamic>> patch(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    await preCheck();
    final response = await dio.patch<dynamic>(
      path,
      data: data,
      options: _defaultOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  /// Execute http delete request
  Future<Response<dynamic>> delete(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async {
    await preCheck();
    final response = await dio.delete<dynamic>(
      path,
      data: data,
      options: _defaultOptions,
      queryParameters: queryParameters,
    );
    return response;
  }

  /// Download data
  Future<Response<dynamic>> download(
    String urlPath,
    String savePath, {
    dynamic data,
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
  }) async {
    await preCheck();
    final response = await dio.download(
      urlPath,
      savePath,
      data: data,
      onReceiveProgress: onReceiveProgress,
      options: _defaultOptions,
      queryParameters: queryParameters,
    );
    return response;
  }
}

abstract class LastFMApiClient extends ApiClientBase {
  LastFMApiClient({required super.dio, required super.appConfig});
}

/// Api client for authentication requests
@Singleton(as: LastFMApiClient)
class LastFMApiClientImpl extends LastFMApiClient {
  LastFMApiClientImpl({required super.dio, required super.appConfig}) {
    dio.options.baseUrl = appConfig.baseUrl;
  }
}
