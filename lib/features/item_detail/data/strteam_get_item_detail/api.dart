import 'package:dio/dio.dart';
import 'package:transhop/models/post.dart';

import '../../../../utils/dio_util.dart';

import '../../../../exceptions/data_source.dart';

final class GetProductDetailApi {
  final DioUtil _dio;
  GetProductDetailApi({required DioUtil dio}) : _dio = dio;
  Future<Post> fetchProductDetail(int id) async {
    try {
      Response response =
          await _dio.getHttp("https://jsonplaceholder.org/posts/$id");
      if (response.statusCode == 200) {
        Post data = Post.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
