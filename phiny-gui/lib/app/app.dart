import 'package:flutter/material.dart';
import 'package:phiny_gui/app/router/app_router.dart';

class PhinyApp extends StatelessWidget {
  const PhinyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
