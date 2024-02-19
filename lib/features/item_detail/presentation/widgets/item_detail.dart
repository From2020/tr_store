import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../models/post.dart';
import '../../../../utils/text_style_util.dart';
import '../../../../utils/ui_helpers_util.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(UIHelper.kDefaulutPadding(), 10.sp,
          UIHelper.kDefaulutPadding(), UIHelper.kDefaulutPadding()),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          width: .7.sw,
          child: Text(
            "${post.id}\$",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextFontStyle.headline20StyleMontserrat.copyWith(
                color: AppColors.headLine1Color, fontWeight: FontWeight.w700),
          ),
        ),
        UIHelper.verticalSpaceSmall,
        //item name
        SizedBox(
          width: .7.sw,
          child: Text(
            post.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextFontStyle.headline20StyleMontserrat.copyWith(
                color: AppColors.headLine2Color, fontWeight: FontWeight.w700),
          ),
        ),
        UIHelper.verticalSpaceSmall,
        // description
        Text(
          post.content,
          style: TextFontStyle.headline13StyleMontserrat
              .copyWith(color: AppColors.headLine1Color, height: 1.5.sp),
        ),
        UIHelper.verticalSpaceMedium,
      ],
    );
  }
}
