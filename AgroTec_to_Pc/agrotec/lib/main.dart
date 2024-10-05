import 'package:legtransito/pages/manual.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Configurar a janela para estar sempre no topo
  WindowOptions windowOptions = const WindowOptions(
    alwaysOnTop: true,
    size: Size(400, 600),
    minimumSize: Size(400, 600),
    maximumSize: Size(400, 600),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAlwaysOnTop(true);
    await windowManager.show();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 0, 0),
          secondary: Color.fromARGB(255, 33, 30, 183),
          surfaceContainer: Color.fromARGB(255, 54, 54, 54),
          surface: Color.fromARGB(255, 240, 240, 240),
          onPrimary: Color(0xff211951),
          onSecondary: Color.fromARGB(255, 243, 243, 243),
          onSurfaceVariant: Color.fromARGB(255, 0, 0, 0),
          onSurface: Color.fromARGB(255, 2, 2, 2),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 233, 233, 233),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 255, 255, 255),
          secondary: Color(0xFFB71E3F),
          surfaceContainer: Colors.black,
          surface: Color.fromARGB(255, 0, 0, 0),
          onPrimary: Color(0xff211951),
          onSecondary: Color.fromARGB(255, 255, 255, 255),
          onSurfaceVariant: Color.fromARGB(255, 255, 255, 255),
          onSurface: Color.fromARGB(255, 255, 255, 255),
        ),
        scaffoldBackgroundColor: const Color(0xff232323),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const AnaliseManual(title: "LegTransito"),
    );
  }
}
