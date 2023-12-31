import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/firebase_options.dart';
import 'package:citchat/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'shared/color_schemas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<PeopleBloc>(
          create: (context) => PeopleBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
            useMaterial3: true, colorScheme: ColorSchema.lightColorScheme),
        darkTheme: ThemeData(
            useMaterial3: true, colorScheme: ColorSchema.darkColorScheme),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
