// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:transhop/models/post.dart';

import '../../../../services/injector.dart';
import '../../../../services/providers/cart_count.dart';
import '../../../../utils/image_shimmer_util.dart';

import '../../../../utils/toast_util.dart';
import '../../../../utils/ui_helpers_util.dart';
import '../../data/stream_cart_count/stream.dart';
import '../../data/stream_delete_cart_item/stream.dart';
import '../../data/stream_get_cart/stream.dart';
import '/gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../utils/text_style_util.dart';

class CartItem extends StatefulWidget {
  final Post? item;
  const CartItem({
    super.key,
    this.item,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UIHelper.verticalSpaceMedium,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: .24.sw,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: widget.item!.thumbnail,
                      height: 83.sp,
                      width: 83.sp,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => imageSimmerCached(83.sp),
                      errorWidget: (context, url, error) =>
                          imageNotFound(83.sp),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium,
                ],
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            SizedBox(
              width: .62.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.verticalSpace(5.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: .4.sw,
                        child: Text(widget.item!.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextFontStyle.headline12StyleMontserrat
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.headLine1Color)),
                      ),
                      Text(widget.item!.id.toString() + " \$",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextFontStyle.headline12StyleMontserrat
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.headLine2Color)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                try {
                  int resault = await locator<DeleteCartStream>()
                      .deleteItemFromCart(widget.item!.id.toString());
                  if (resault == 1) {
                    if (!mounted) return;
                    ToastUtil.showShortToast("Item removed from cart");
                    locator<GetCartCountStream>().fetchCartData().then(
                        (value) =>
                            context.read<CountNotifier>().setCount = value);
                    locator<GetCartStream>().fetchCartData();
                  }
                } catch (error) {
                  ToastUtil.showShortToast("Operation Failed");
                  log(error.toString());
                }
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    color: AppColors.loginBackground,
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: SvgPicture.asset(
                  Assets.icons.delete,
                  color: AppColors.penIconColor,
                ),
              ),
            ),
          ],
        ),
        UIHelper.verticalSpaceMedium,
        UIHelper.customDivider(),
      ],
    );
  }
}
