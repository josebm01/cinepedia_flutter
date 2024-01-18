//? Importaciones de dart

//? Importaciones de flutter
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//? Dependencias
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  //? Leyendo archivos de variables de entorno
  await dotenv.load(fileName: ".env");
  runApp(
    //? riverpod - para mantener todas las referencias de los provider de riverpod
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),      
    );
  }
}