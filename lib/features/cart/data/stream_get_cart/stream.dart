import 'package:transhop/features/cart/data/stream_get_cart/db.dart';
import 'package:transhop/models/post.dart';
import 'package:transhop/utils/base_stream_util.dart';

final class GetCartStream extends MyStreamBase<List<Post>> {
  final GetCartDao _dao;

  GetCartStream({required GetCartDao dao, required super.empty})
      : _dao = dao; // init with List.empty()

  Future<void> fetchCartData() async {
    try {
      List<Post> carttData = await _dao.selectAllCart();
      handleSuccessWithReturn(carttData);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }
}
