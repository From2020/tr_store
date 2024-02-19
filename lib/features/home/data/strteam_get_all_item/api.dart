import 'package:dio/dio.dart';
import 'package:transhop/models/post.dart';

import '../../../../exceptions/data_source.dart';
import '../../../../utils/dio_util.dart';

final class GetAllShopItemApi {
  final DioUtil _dio;
  GetAllShopItemApi({required DioUtil dio}) : _dio = dio;

  Future<List<Post>> fetchAllPost([int page = 1]) async {
    try {
      Response response =
          await _dio.getHttp("https://jsonplaceholder.org/posts");
      if (response.statusCode == 200) {
        List<Post> data = Post.fromList((response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
