import 'package:dio/dio.dart';

import '../services/dio/dio_init.dart';

class DioUtil {
  Future<Response> postHttp(String path, [dynamic data]) =>
      DioSingleton.instance.dio
          .post(path, data: data, cancelToken: DioSingleton.cancelToken);

  Future<Response> putHttp(String path, [dynamic data]) =>
      DioSingleton.instance.dio
          .put(path, data: data, cancelToken: DioSingleton.cancelToken);

  Future<Response> getHttp(String path, [dynamic data]) =>
      DioSingleton.instance.dio
          .get(path, cancelToken: DioSingleton.cancelToken);

  Future<Response> deleteHttp(String path, [dynamic data]) =>
      DioSingleton.instance.dio
          .delete(path, data: data, cancelToken: DioSingleton.cancelToken);
}
