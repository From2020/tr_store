import 'package:transhop/utils/base_stream_util.dart';

import 'db.dart';

final class DeleteCartStream extends MyStreamBase<int> {
  final DeleteCartItemDao _dao;

  DeleteCartStream({required DeleteCartItemDao dao, required super.empty})
      : _dao = dao; // init with 0

  Future<int> deleteItemFromCart(String id) async {
    try {
      int cartCount = await _dao.daleteCartItem(id);
      return handleSuccessWithReturn(cartCount);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }
}
