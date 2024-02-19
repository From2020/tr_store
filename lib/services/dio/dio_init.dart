import 'package:dio/dio.dart';

import '../../constants/network_constants.dart';
import 'log.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;

  Future<Dio> create() async {
    BaseOptions options = BaseOptions(
        connectTimeout: const Duration(milliseconds: 100000),
        receiveTimeout: const Duration(milliseconds: 100000),
        headers: {
          NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        });
    dio = Dio(options)..interceptors.add(Logger());
    return dio;
  }
}
