import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/add_edit_item/view/add_edit_item_view.dart';
import '../../presentation/auth/view/auth_view.dart';
import '../../presentation/home/view/home_view.dart';
import '../../presentation/profile/view/profile_view.dart';
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
        String? productId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => AddEditItemView(
            itemId: productId,
          ),
        );
      case AppRouterNames.profileRouteName:
        return CupertinoPageRoute(builder: (_) => const ProfileView());
      default:
        return null;
    }
  }
}
