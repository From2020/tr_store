import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../gen/colors.gen.dart';

import '../services/providers/cart_count.dart';
import 'icon_holder_widget.dart';

final class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CountNotifier>(
      builder: (context, state, child) {
        return badges.Badge(
          position: badges.BadgePosition.topEnd(top: -8, end: -5),
          showBadge: state.count != 0,
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeContent: Text(
            state.count.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          child: const IconHolder(
              icon: Icons.shopping_cart_outlined,
              iconColor: AppColors.penIconColor,
              bgColor: AppColors.linkColor),
        );
      },
    );
  }
}
