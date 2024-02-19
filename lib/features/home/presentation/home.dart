import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:transhop/models/post.dart';

import '../../../common_widgets/cart_icon.dart' show CartIcon;
import '../../../utils/text_style_util.dart';
import '../../../routing/all_routes.dart';
import '../../../services/injector.dart';

import '../../../services/navigation_service.dart';
import '../../cart/presentation/cart.dart';
import '../data/strteam_get_all_item/stream.dart';
import 'widgets/item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      List<Post> posts =
          await locator<GetAllItemStream>().fetchAllItemData(pageKey);
      _pagingController.appendPage(posts, pageKey + 1);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 10,
          title: Text("Welocme To TR Shop",
              style: TextFontStyle.headline16StyleMontserrat600),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  NavigationService.navigateToWithObject(
                      Routes.navigationScreen, const CartScreen());
                },
                child: const CartIcon(),
              ),
            ),
          ]),
      body: PagedListView<int, Post>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, post, index) => Container(
            padding: const EdgeInsets.only(
              left: 12.0,
              top: 6.0,
              right: 12.0,
              bottom: 6.0,
            ),
            child: ItemHeader(shopProducts: post),
          ),
        ),
      ),
    );
  }
}
