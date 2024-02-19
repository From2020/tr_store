import 'package:transhop/models/post.dart';
import 'package:transhop/utils/base_stream_util.dart';

import 'db.dart';

final class PostCartStream extends MyStreamBase<int> {
  final PostCartDao _dao;

  PostCartStream({required PostCartDao dao, required super.empty})
      : _dao = dao; // init with 0

  Future<int> postCartData(Post post) async {
    try {
      int cartcount = await _dao.saveCartData(post);
      return handleSuccessWithReturn(cartcount);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }
}
