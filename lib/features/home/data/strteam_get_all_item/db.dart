import '../../../../constants/db_table_constants.dart';
import '../../../../exceptions/data_source.dart';
import '../../../../utils/db_util.dart';
import '../../../../models/post.dart';

class GetAllShopItemDao {
  final DbUtil _dbUtil;
  GetAllShopItemDao({required DbUtil dbUtil}) : _dbUtil = dbUtil;

  Future<List<Post>> getAllPost({
    int? limit,
    int? offset,
  }) async {
    try {
      List<Map<String, dynamic>> resultdata =
          await _dbUtil.getAllData(TableConst.kPostsTableName, limit, offset);
      return List.generate(resultdata.length, (i) {
        return Post.fromJson(resultdata[i]);
      });
    } catch (error) {
      throw ErrorHandler.handle(error).failure;
    }
  }

  void saveAllPost(List<Post> posts) {
    _dbUtil.insertBatchData(table: TableConst.kPostsTableName, entities: posts);
  }
}
