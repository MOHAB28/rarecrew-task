import 'package:flutter/material.dart';

import '../../presentation/auth/auth_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../services/cache_helper.dart';

class AppRouterNames {
  static const String authRouteName = '/auth';
  static const String homeRouteName = '/home';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        var token =
            CacheHelper.getDataFromSharedPreference(key: 'token');
        if (token != null) {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        } else {
          return MaterialPageRoute(builder: (_) => const AuthScreen());
        }
      case AppRouterNames.authRouteName:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case AppRouterNames.homeRouteName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return null;
    }
  }
}
