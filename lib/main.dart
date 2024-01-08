import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configs/di/injector.dart';
import 'configs/router/app_router.dart';
import 'configs/storage/storage_manager.dart';
import 'configs/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

Future<void> initApp() async {
  configureDependencies();
  await sl<StorageManager>().init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Talking',
      routerConfig: AppRouter.router,
      theme: AppTheme.light,
    );
  }
}
