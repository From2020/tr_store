import 'package:transhop/constants/db_table_constants.dart';

import '../../../../exceptions/data_source.dart';
import '../../../../utils/db_util.dart';

class DeleteCartItemDao {
  final DbUtil _dbUtil;
  DeleteCartItemDao({required DbUtil dbUtil}) : _dbUtil = dbUtil;

  Future<int> daleteCartItem(String identity) async {
    try {
      int response = await _dbUtil.deleteData(
          table: TableConst.kCartTableName, where: "id = ?", id: identity);
      return response;
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
