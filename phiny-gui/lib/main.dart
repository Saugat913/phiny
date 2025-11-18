import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phiny_gui/app/app.dart';
import 'package:phiny_gui/app/app_provider.dart';
import 'package:phiny_gui/src/rust/frb_generated.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'src/rust/api/phiny_core_adaptor.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await RustLib.init();

  WindowOptions windowsOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowsOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setTitle("Phiny");
    await windowManager.setMinimumSize(const Size(800, 600));
  });

  final sharedPreferenceInstance = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferenceProvider.overrideWithValue(sharedPreferenceInstance),
      ],
      child: PhinyApp(),
    ),
  );
}
