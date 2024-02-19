import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:transhop/models/post.dart';

import '../../../../routing/all_routes.dart';
import '../../../../services/injector.dart';
import '../../../../services/providers/cart_count.dart';
import '../../../../services/providers/item_id.dart';
import '../../../../utils/image_shimmer_util.dart';

import '../../../../services/navigation_service.dart';

import '../../../../utils/toast_util.dart';
import '../../../../utils/ui_helpers_util.dart';

import '../../../../gen/colors.gen.dart';

import '../../../../utils/text_style_util.dart';

import '../../../../common_widgets/icon_holder_widget.dart';

import '../../../cart/data/stream_cart_count/stream.dart';
import '../../../cart/data/stream_post_cart/stream.dart';

class ItemHeader extends StatefulWidget {
  final Post shopProducts;
  const ItemHeader({
    super.key,
    required this.shopProducts,
  });

  @override
  State<ItemHeader> createState() => _ItemHeaderState();
}

class _ItemHeaderState extends State<ItemHeader> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ItemIdNotifier>().setId = widget.shopProducts.id;
        NavigationService.navigateTo(Routes.itemDetail);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: UIHelper.kDefaulutPadding()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: widget.shopProducts.thumbnail,
                height: 83.sp,
                width: 83.sp,
                fit: BoxFit.cover,
                placeholder: (context, url) => imageSimmerCached(83.sp),
                errorWidget: (context, url, error) => imageNotFound(83.sp),
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            SizedBox(
              height: 83.sp,
              width: .56.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(5.sp),
                  Text(widget.shopProducts.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextFontStyle.headline12StyleMontserrat500.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  UIHelper.verticalSpace(5.sp),
                  Text("${widget.shopProducts.userId}\$",
                      style: TextFontStyle.headline14StyleMontserrat400),
                  UIHelper.verticalSpace(5.sp),
                ],
              ),
            ),
            const Spacer(),
            UIHelper.verticalSpaceLarge,
            InkWell(
              onTap: () async {
                try {
                  int respose = await locator<PostCartStream>().postCartData(
                    Post(
                        id: widget.shopProducts.id,
                        title: widget.shopProducts.title,
                        content: widget.shopProducts.content,
                        image: widget.shopProducts.image,
                        thumbnail: widget.shopProducts.thumbnail,
                        userId: widget.shopProducts.userId),
                  );
                  if (respose.isFinite) {
                    ToastUtil.showShortToast("Item added on cart");
                    if (!mounted) return;
                    locator<GetCartCountStream>().fetchCartData().then(
                        (value) =>
                            context.read<CountNotifier>().setCount = value);
                  }
                } catch (e) {
                  ToastUtil.showShortToast("Duplicate Item Found");
                  log(e.toString());
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 6.r),
                child: const IconHolder(
                  height: 29,
                  width: 29,
                  icon: Icons.add,
                  bgColor: AppColors.loginBackground,
                  iconColor: AppColors.penIconColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
