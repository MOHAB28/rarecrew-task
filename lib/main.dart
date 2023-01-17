import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/styles/app_theme.dart';

void main() {
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    required this.appRouter,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: appTheme(),
    );
  }
}
