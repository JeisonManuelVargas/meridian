import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meridian/core/navigation/navigator.dart';
import 'package:meridian/core/util/app_theme.dart';
import 'package:meridian/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getThemeData(context),
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.generateRoute,
    );
  }
}
