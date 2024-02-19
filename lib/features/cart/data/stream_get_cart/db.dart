import 'package:transhop/models/post.dart';

import '../../../../constants/db_table_constants.dart';
import '../../../../exceptions/data_source.dart';
import '../../../../utils/db_util.dart';

class GetCartDao {
  final DbUtil _dbUtil;
  GetCartDao({required DbUtil dbUtil}) : _dbUtil = dbUtil;

  Future<List<Post>> selectAllCart({
    int? limit,
    int? offset,
  }) async {
    try {
      List<Map<String, dynamic>> resultdata =
          await _dbUtil.getAllData(TableConst.kCartTableName, limit, offset);
      return List.generate(resultdata.length, (i) {
        return Post.fromJson(resultdata[i]);
      });
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
