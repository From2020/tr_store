import 'package:transhop/models/post.dart';

import '../../../../constants/db_table_constants.dart';
import '../../../../exceptions/data_source.dart';
import '../../../../utils/db_util.dart';

class PostCartDao {
  final DbUtil _dbUtil;
  PostCartDao({required DbUtil dbUtil}) : _dbUtil = dbUtil;

  Future<int> saveCartData(Post entity) async {
    try {
      int response = await _dbUtil.saveData(
          TableConst.kCartTableName, entity.toJsonForDb());
      return response;
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
