import 'package:flutter/widgets.dart';
import 'package:phiny_gui/app/app.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

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
  runApp(PhinyApp());
}
