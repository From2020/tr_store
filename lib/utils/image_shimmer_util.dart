import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../gen/assets.gen.dart';

Widget imageSimmerCached(double? height) {
  return SizedBox(
    height: height,
    child: Center(
      child: Lottie.asset(Assets.lottie.imageShimmer,
          height: height, width: height),
    ),
  );
}

Widget imageNotFound(double? height) {
  return Image.asset(
    Assets.images.errorProduct.path,
    height: height,
    width: height,
  );
}
