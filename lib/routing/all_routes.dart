import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:transhop/features/item_detail/presentation/item_details.dart';

import '../features/cart/presentation/cart.dart';
import '../features/home/presentation/home.dart';
import '../navigation_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  static const String home = '/homeScreen';
  static const String cartScreen = '/CartScreen';
  static const String itemDetail = '/itemDetailScreen';
  static const String navigationScreen = '/NavigationScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const HomeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => const HomeScreen());
      case Routes.cartScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const CartScreen(backButtonVisible: true),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) =>
                    const CartScreen(backButtonVisible: true));
      case Routes.itemDetail:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ItemDetailScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ItemDetailScreen());
      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavigationScreen(), settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen());
      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}
