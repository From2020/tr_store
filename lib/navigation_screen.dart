import 'package:badges/badges.dart' as badges;
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transhop/features/home/presentation/home.dart';

import 'common_widgets/exit_dialog.dart';
import 'utils/text_style_util.dart';
import 'features/cart/presentation/cart.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';
import 'services/providers/cart_count.dart';

final class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    super.key,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  bool _isFisrtBuild = true;

  final List<StatefulWidget> _screens = [
    const HomeScreen(),
    const CartScreen(),
  ];

  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object? args;
    StatefulWidget? screenPage;
    if (_isFisrtBuild) {
      args = ModalRoute.of(context)!.settings.arguments;
    }

    //when object are passed as perameter this method checkes if it's registered and open it's navigation bar
    if (args != null) {
      colorIndex = 5;
      screenPage = args as StatefulWidget;
      var newColorindex = -1;
      for (var element in _screens) {
        newColorindex++;
        if (element.toString() == screenPage.toString()) {
          colorIndex = newColorindex;
          _currentIndex = newColorindex;
          _isFisrtBuild = false;
          break;
        }
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Center(
            child: (screenPage != null)
                ? screenPage
                : _screens.elementAt(_currentIndex)),
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 30.r,
          items: [
            CustomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.home,
                theme: SvgTheme(
                    currentColor: (_currentIndex == 0)
                        ? AppColors.penIconColor
                        : AppColors.disabledColor),
              ),
              title: Text("Home",
                  style: TextFontStyle.headline12StyleMontserrat.copyWith(
                    color: (_currentIndex == 0)
                        ? AppColors.penIconColor
                        : AppColors.disabledColor,
                  )),
            ),
            CustomNavigationBarItem(
              title: Text(
                "Cart   ",
                style: TextFontStyle.headline12StyleMontserrat.copyWith(
                  color: (_currentIndex == 1)
                      ? AppColors.penIconColor
                      : AppColors.disabledColor,
                ),
              ),
              icon: Consumer<CountNotifier>(
                builder: (context, state, child) {
                  return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -8, end: -20),
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
                    child: SvgPicture.asset(
                      Assets.icons.cart,
                      theme: SvgTheme(
                          currentColor: (_currentIndex == 1)
                              ? AppColors.penIconColor
                              : AppColors.disabledColor),
                    ),
                  );
                },
              ),
            )
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
