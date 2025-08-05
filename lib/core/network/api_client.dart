import 'package:dio/dio.dart';
import '../env/env_config.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(BaseOptions(
          baseUrl: EnvConfig.apiBaseUrl,
          connectTimeout: Duration(milliseconds: EnvConfig.apiTimeout),
          receiveTimeout: Duration(milliseconds: EnvConfig.apiTimeout),
        )) {
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (object) {
        // Only log in development mode
        if (EnvConfig.isDev) {
          print(object);
        }
      },
    ));
  }

  Future<Response> get(String path) async => dio.get(path);

  Future<Response> post(String path, Map<String, dynamic> data) async =>
      dio.post(path, data: data);

  Future<Response> put(String path, Map<String, dynamic> data) async =>
      dio.put(path, data: data);

  Future<Response> delete(String path) async => dio.delete(path);
}
