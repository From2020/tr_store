import 'package:sqflite/sqflite.dart';

import '../../../../exceptions/data_source.dart';
import '../../../../utils/db_util.dart';

class GetCartCountDao {
  final DbUtil _dbUtil;
  GetCartCountDao({required DbUtil dbUtil}) : _dbUtil = dbUtil;
  Future<int> getCartCount(String query) async {
    try {
      List<Map<String, dynamic>> response = await _dbUtil.queryString(query);
      int? count = Sqflite.firstIntValue(response);
      return count ?? 0;
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
