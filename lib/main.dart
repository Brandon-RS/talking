import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/router/app_router.dart';
import 'configs/theme/app_theme.dart';
import 'presentation/providers/auth/auth.provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'Talking',
        routerConfig: AppRouter.router,
        theme: AppTheme.light,
      ),
    );
  }
}
