import 'package:flutter/material.dart';

import '../../presentation/auth/auth_screen.dart';
import '../../presentation/layout/layout_screen.dart';

class AppRouterNames {
  static const String authRouteName = '/auth';
  static const String layoutRouteName = '/layout';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case AppRouterNames.authRouteName:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case AppRouterNames.layoutRouteName:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      default:
        return null;
    }
  }
}
