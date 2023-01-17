import 'package:flutter/material.dart';

import '../../presentation/auth/auth_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      return MaterialPageRoute(builder: (_) => const AuthScreen());
      default:
        return null;
    }
  }
}
