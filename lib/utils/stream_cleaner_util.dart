import 'dart:ui';

import '../features/cart/data/stream_cart_count/stream.dart';
import '../features/cart/data/stream_delete_cart_item/stream.dart';
import '../features/cart/data/stream_get_cart/stream.dart';
import '../features/cart/data/stream_post_cart/stream.dart';

import '../features/home/data/strteam_get_all_item/stream.dart';
import '../features/item_detail/data/strteam_get_item_detail/stream.dart';
import '../services/injector.dart';

Future<AppExitResponse> totalDataClean() async {
  locator<GetCartStream>().dispose();
  locator<PostCartStream>().dispose();
  locator<GetProductDetailStream>().dispose();
  locator<GetAllItemStream>().dispose();
  locator<GetCartCountStream>().dispose();
  locator<DeleteCartStream>().dispose();
  return AppExitResponse.exit;
}
