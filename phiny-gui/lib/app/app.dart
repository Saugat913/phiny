import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phiny_gui/app/app_router.dart';

class PhinyApp extends ConsumerWidget {
  const PhinyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(AppRouter.router),
    );
  }
}
