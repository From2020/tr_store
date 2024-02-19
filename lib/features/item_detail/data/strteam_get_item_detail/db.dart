import 'package:transhop/models/post.dart';
import 'package:transhop/utils/db_util.dart';

import '../../../../constants/db_table_constants.dart';
import '../../../../exceptions/data_source.dart';

class GetProductDetailDao {
  final DbUtil _dioUtil;

  GetProductDetailDao({required DbUtil dioUtil}) : _dioUtil = dioUtil;

  Future<List<Post>> fetchProductDetailFromDb({
    required int id,
  }) async {
    try {
      List<Map<String, dynamic>> resultdata = await _dioUtil.getDataByID(
          table: TableConst.kPostsTableName,
          where: "id = ?",
          id: id.toString());

      return List.generate(resultdata.length, (i) {
        return Post.fromJson(resultdata[i]);
      });
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }
}
