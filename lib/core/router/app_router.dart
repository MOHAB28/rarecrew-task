import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/add_edit_item/add_edit_item_view.dart';
import '../../presentation/auth/auth_view.dart';
import '../../presentation/home/home_view.dart';
import '../../presentation/profile/profile_view.dart';
import '../services/cache_helper.dart';

class AppRouterNames {
  static const String authRouteName = '/auth';
  static const String homeRouteName = '/home';
  static const String profileRouteName = '/profile';
  static const String addRouteName = '/add-item';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        var token = CacheHelper.getDataFromSharedPreference(key: 'token');
        if (token != null) {
          return MaterialPageRoute(builder: (_) => const HomeView());
        } else {
          return MaterialPageRoute(builder: (_) => const AuthView());
        }
      case AppRouterNames.authRouteName:
        return MaterialPageRoute(builder: (_) => const AuthView());
      case AppRouterNames.homeRouteName:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRouterNames.addRouteName:
        return MaterialPageRoute(builder: (_) => const AddEditItemView());
      case AppRouterNames.profileRouteName:
        return CupertinoPageRoute(builder: (_) => const ProfileView());
      default:
        return null;
    }
  }
}
