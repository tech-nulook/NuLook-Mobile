import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get _context {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      throw Exception("Navigation context is null");
    }
    return ctx;
  }

  /// go to route (replace stack)
  static void go(String location) {
    _context.go(location);
  }

  /// go to named route (replace stack)
  static void goNamed(
      String name, {
        Map<String, String> pathParameters = const {},
        Map<String, dynamic> queryParameters = const {},
        Object? extra,
      }) {
    _context.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// push route (keep back stack)
  static Future<T?> push<T>(String location, {Object? extra}) {
    return _context.push<T>(location, extra: extra);
  }

  /// push named route (keep back stack)
  static Future<T?> pushNamed<T>(
      String name, {
        Map<String, String> pathParameters = const {},
        Map<String, dynamic> queryParameters = const {},
        Object? extra,
      }) {
    return _context.pushNamed<T>(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// push replacement
  static void pushReplacement(String location, {Object? extra}) {
    _context.pushReplacement(location, extra: extra);
  }

  /// back
  static void pop<T extends Object?>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop(result);
    }
  }
}