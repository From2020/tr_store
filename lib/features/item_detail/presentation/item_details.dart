import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transhop/features/cart/data/stream_post_cart/stream.dart';
import 'package:transhop/models/post.dart';
import 'package:transhop/services/providers/item_id.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/loading_indicators.dart';
import '../../../gen/colors.gen.dart';
import '../../../services/injector.dart';
import '../../../services/providers/cart_count.dart';
import '../../../utils/toast_util.dart';
import '../../../utils/ui_helpers_util.dart';
import '../../cart/data/stream_cart_count/stream.dart';
import '../../cart/data/stream_get_cart/stream.dart';
import '../data/strteam_get_item_detail/stream.dart';
import 'widgets/item_detail.dart';
import 'widgets/item_header.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  void initState() {
    super.initState();
    locator<GetProductDetailStream>()
        .fetchProductDetail(context.read<ItemIdNotifier>().id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<Post>(
          stream: locator<GetProductDetailStream>().broadCastStream,
          builder: (context, AsyncSnapshot<Post> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              Post? post = snapshot.data;
              if (post != null) {
                locator<GetCartStream>().fetchCartData();
                return ListView(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Itemheader(post: post),
                    UIHelper.verticalSpaceMedium,
                    ItemDetail(post: post),
                    Padding(
                      padding: EdgeInsets.only(
                          left: UIHelper.kDefaulutPadding(),
                          right: UIHelper.kDefaulutPadding()),
                      child: customeButton(
                          name: "Add Item",
                          onCallBack: () async {
                            try {
                              int response =
                                  await locator<PostCartStream>().postCartData(
                                Post(
                                    id: post.id,
                                    title: post.title,
                                    content: post.content,
                                    image: post.image,
                                    thumbnail: post.thumbnail,
                                    userId: post.userId),
                              );

                              if (response.isFinite) {
                                if (!mounted) return;
                                ToastUtil.showShortToast("Item added on cart");
                                locator<GetCartCountStream>()
                                    .fetchCartData()
                                    .then((value) => context
                                        .read<CountNotifier>()
                                        .setCount = value);
                              }
                            } catch (e) {
                              ToastUtil.showShortToast("Duplicate Item Found");
                              log(e.toString());
                            }
                          },
                          height: 56.sp,
                          minWidth: 1.sw,
                          borderRadius: 30.r,
                          borderColor: AppColors.penIconColor,
                          color: AppColors.linkColor,
                          textStyle: GoogleFonts.montserrat(
                              fontSize: 17.sp,
                              color: AppColors.headLine1Color,
                              fontWeight: FontWeight.w700),
                          context: context),
                    ),
                    UIHelper.verticalSpaceLarge,
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            } else if (snapshot.hasError) {
              return const SizedBox.shrink();
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: loadingIndicatorCircle(context: context),
              ),
            );
          }),
    );
  }
}
