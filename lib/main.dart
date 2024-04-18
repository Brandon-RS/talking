import 'package:flutter/material.dart';
import 'package:talking/configs/di/injector.dart';
import 'package:talking/configs/storage/storage_manager.dart';
import 'package:talking/talking_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(const TalkingApp());
}

Future<void> initApp() async {
  configureDependencies();
  await sl<StorageManager>().init();
}
