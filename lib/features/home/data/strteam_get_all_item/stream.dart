import 'package:transhop/utils/base_stream_util.dart';

import '../../../../models/post.dart';

import 'api.dart';
import 'db.dart';

final class GetAllItemStream extends MyStreamBase<List<Post>> {
  final GetAllShopItemApi _api;
  final GetAllShopItemDao _db;

  GetAllItemStream(
      {required GetAllShopItemApi api,
      required GetAllShopItemDao db,
      required super.empty})
      : _api = api,
        _db = db;
  //init with List.empty()

  Future<List<Post>> fetchAllItemData([int page = 1]) async {
    try {
      List<Post> posts =
          await _db.getAllPost(limit: 10, offset: (10 * page) - 10);

      if (posts.isNotEmpty) {
        return posts;
      }
      List<Post> allPost = await _api.fetchAllPost(page);
      _db.saveAllPost(allPost);
      return handleSuccessWithReturn(allPost);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }
}
