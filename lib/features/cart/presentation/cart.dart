import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:transhop/features/cart/data/stream_get_cart/stream.dart';
import 'package:transhop/models/post.dart';
import 'package:transhop/services/navigation_service.dart';

import '../../../../gen/colors.gen.dart';
import '../../../common_widgets/icon_holder_widget.dart';
import '../../../common_widgets/loading_indicators.dart';
import '../../../utils/text_style_util.dart';

import '../../../services/injector.dart';
import '../../../utils/ui_helpers_util.dart';
import '/features/cart/presentation/widgets/ordered_item.dart';
import '/gen/assets.gen.dart';

class CartScreen extends StatefulWidget {
  final bool backButtonVisible;
  const CartScreen({this.backButtonVisible = false, super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    locator<GetCartStream>().fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: StreamBuilder<List<Post>>(
          stream: locator<GetCartStream>().broadCastStream,
          builder: (context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List<Post>? post = snapshot.data;
              if (post != null && post.isNotEmpty) {
                return ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
                  children: [
                    UIHelper.verticalSpaceMediumLarge,
                    //app bar
                    Row(children: [
                      if (widget.backButtonVisible)
                        InkWell(
                          onTap: () async {
                            NavigationService.goBeBack;
                          },
                          child: IconHolder(
                            icon: Icons.arrow_back_ios_new,
                            size: 18.sp,
                            bgColor: AppColors.linkColor,
                            iconColor: AppColors.penIconColor,
                          ),
                        ),
                      UIHelper.horizontalSpaceMedium,
                      Text(
                        "Cart",
                        style: TextFontStyle.headline20StyleMontserrat.copyWith(
                            color: AppColors.headLine1Color,
                            fontWeight: FontWeight.w600,
                            fontSize: 19.sp),
                      ),
                    ]),
                    UIHelper.verticalSpaceSmall,
                    UIHelper.customDivider(),
                    UIHelper.verticalSpaceMediumLarge,
                    Text("Your Cart Item",
                        style: TextFontStyle.headline19StyleMontserrat),
                    UIHelper.verticalSpace(3.w),
                    UIHelper.verticalSpaceSmall,
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: post.length,
                      itemBuilder: (context, index) => CartItem(
                        item: post[index],
                      ),
                    ),
                    UIHelper.verticalSpaceSemiLarge,
                    UIHelper.verticalSpaceLarge,
                  ],
                );
              } else {
                return Center(
                    child: Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    Assets.lottie.cartIsEmpty,
                  ),
                ));
              }
            } else if (snapshot.hasError) {
              return const SizedBox.shrink();
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: loadingIndicatorCircle(context: context, size: 50),
            );
          }),
    );
  }
}
