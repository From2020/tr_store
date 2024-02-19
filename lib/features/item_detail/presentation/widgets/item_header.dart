import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common_widgets/cart_icon.dart';
import '../../../../common_widgets/icon_holder_widget.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../models/post.dart';
import '../../../../routing/all_routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../utils/image_shimmer_util.dart';
import '../../../../utils/ui_helpers_util.dart';
import '../../../cart/presentation/cart.dart';

class Itemheader extends StatelessWidget {
  const Itemheader({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CachedNetworkImage(
        imageUrl: post.image,
        fit: BoxFit.cover,
        placeholder: (context, url) => imageSimmerCached(null),
        errorWidget: (context, url, error) => imageNotFound(null),
      ),
      Positioned(
        top: UIHelper.safePadding(),
        left: 12.sp,
        child: InkWell(
          onTap: () {
            NavigationService.goBack;
          },
          child: IconHolder(
            icon: Icons.arrow_back_ios_new,
            size: 18.sp,
            bgColor: AppColors.linkColor,
            iconColor: AppColors.penIconColor,
          ),
        ),
      ),
      Positioned(
        top: UIHelper.safePadding(),
        right: 12.sp,
        child: InkWell(
          onTap: () {
            NavigationService.navigateToWithObject(
                Routes.navigationScreen, const CartScreen());
          },
          child: const CartIcon(),
        ),
      ),
    ]);
  }
}
