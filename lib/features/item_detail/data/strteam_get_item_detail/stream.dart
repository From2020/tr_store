import 'package:transhop/models/post.dart';
import 'package:transhop/utils/base_stream_util.dart';

import 'api.dart';
import 'db.dart';

final class GetProductDetailStream extends MyStreamBase<Post> {
  final GetProductDetailApi _api;
  final GetProductDetailDao _db;

  GetProductDetailStream(
      {required GetProductDetailApi api,
      required GetProductDetailDao db,
      required super.empty}) //init with Post.empty()
      : _api = api,
        _db = db;

  Future<void> fetchProductDetail(int id) async {
    try {
      List<Post> posts = await _db.fetchProductDetailFromDb(id: id);
      late Post post;
      if (posts.isNotEmpty) {
        post = posts.first;
      } else {
        post = await _api.fetchProductDetail(id);
      }
      handleSuccessWithReturn(post);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
