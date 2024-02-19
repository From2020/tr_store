import 'package:transhop/utils/base_stream_util.dart';

import '../../../../constants/db_table_constants.dart';
import 'db.dart';

final class GetCartCountStream extends MyStreamBase<int> {
  final GetCartCountDao _dao;

  GetCartCountStream({required GetCartCountDao dao, required super.empty})
      : _dao = dao; // init with 0
  Future<int> fetchCartData() async {
    try {
      int cartCount = await _dao
          .getCartCount("SELECT COUNT(*) FROM ${TableConst.kCartTableName}");
      return handleSuccessWithReturn(cartCount);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }
}
