import 'package:citchat/routes/router.dart';
import 'package:flutter/material.dart';
import 'shared/color_schemas.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorSchema.lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: ColorSchema.darkColorScheme),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
