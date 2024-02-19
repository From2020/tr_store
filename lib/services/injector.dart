import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:transhop/features/home/data/strteam_get_all_item/db.dart';

import 'package:transhop/features/item_detail/data/strteam_get_item_detail/stream.dart';

import '../features/cart/data/stream_cart_count/db.dart';
import '../features/cart/data/stream_cart_count/stream.dart';
import '../features/cart/data/stream_delete_cart_item/db.dart';
import '../features/cart/data/stream_delete_cart_item/stream.dart';
import '../features/cart/data/stream_get_cart/db.dart';
import '../features/cart/data/stream_get_cart/stream.dart';
import '../features/cart/data/stream_post_cart/db.dart';
import '../features/cart/data/stream_post_cart/stream.dart';
import '../features/home/data/strteam_get_all_item/api.dart';
import '../features/home/data/strteam_get_all_item/stream.dart';
import '../features/item_detail/data/strteam_get_item_detail/api.dart';
import '../features/item_detail/data/strteam_get_item_detail/db.dart';
import '../models/post.dart';
import '../services/dao/db_init.dart';

import '../services/dio/dio_init.dart';
import '../utils/db_util.dart';
import '../utils/dio_util.dart';
import '../utils/stream_cleaner_util.dart';

final locator = GetIt.instance;

void diSetup() {
  //core service db and api initialization
  locator.registerSingletonAsync(() => DioSingleton.instance.create());
  locator.registerSingletonAsync(() => DbSingleton.instance.create());

  //db and dio helper util registration
  locator.registerSingleton<DbUtil>(DbUtil());
  locator.registerSingleton<DioUtil>(DioUtil());
  locator.registerSingleton<AppLifecycleListener>(AppLifecycleListener(
    onExitRequested: totalDataClean,
  ));

//get cart
  locator
      .registerLazySingleton<GetCartDao>(() => GetCartDao(dbUtil: locator()));
  locator.registerLazySingleton<GetCartStream>(
      () => GetCartStream(dao: locator(), empty: []));

//post cart
  locator
      .registerLazySingleton<PostCartDao>(() => PostCartDao(dbUtil: locator()));
  locator.registerLazySingleton<PostCartStream>(
      () => PostCartStream(dao: locator(), empty: 0));

//delete cart
  locator.registerLazySingleton<DeleteCartItemDao>(
      () => DeleteCartItemDao(dbUtil: locator()));
  locator.registerLazySingleton<DeleteCartStream>(
      () => DeleteCartStream(dao: locator(), empty: 0));

//all item
  locator.registerLazySingleton<GetAllShopItemApi>(
      () => GetAllShopItemApi(dio: locator()));
  locator.registerLazySingleton<GetAllShopItemDao>(
      () => GetAllShopItemDao(dbUtil: locator()));
  locator.registerLazySingleton<GetAllItemStream>(
      () => GetAllItemStream(db: locator(), api: locator(), empty: []));

//product detail
  locator.registerLazySingleton<GetProductDetailApi>(
      () => GetProductDetailApi(dio: locator()));
  locator.registerLazySingleton<GetProductDetailDao>(
      () => GetProductDetailDao(dioUtil: locator()));
  locator.registerLazySingleton<GetProductDetailStream>(
      () => GetProductDetailStream(
            api: locator(),
            db: locator(),
            empty: Post.empty(),
          ));

//cart count
  locator.registerLazySingleton<GetCartCountDao>(
      () => GetCartCountDao(dbUtil: locator()));
  locator.registerLazySingleton<GetCartCountStream>(
      () => GetCartCountStream(dao: locator(), empty: 0));
}
