import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioInjection {
  @injectable
  Dio get dio => Dio();
}
