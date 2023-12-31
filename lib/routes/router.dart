import 'package:citchat/models/user_model.dart';
import 'package:citchat/pages/auth/login_page.dart';
import 'package:citchat/pages/auth/register_page.dart';
import 'package:citchat/pages/home/chat/chat_page.dart';
import 'package:citchat/pages/home/home_page.dart';
import 'package:citchat/pages/home/profile/edit_profile_page.dart';
import 'package:citchat/pages/onboarding/on_boarding_page.dart';
import 'package:citchat/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'route_name.dart';

final router = GoRouter(
    errorBuilder: (context, state) => const Text('Not found'),
    routes: [
      GoRoute(
        path: '/',
        name: RouteName.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
          path: '/onboarding',
          name: RouteName.onBoarding,
          builder: (context, state) => const OnBoardingPage(),
          routes: [
            GoRoute(
              path: 'register',
              name: RouteName.register,
              builder: (context, state) => const RegisterPage(),
            ),
          ]),
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: '/home',
          name: RouteName.home,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: ':uid',
              name: RouteName.chat,
              builder: (context, state) {
                User user = state.extra as User;
                return ChatPage(
                  uid: state.pathParameters["uid"]!,
                  user: user,
                );
              },
            ),
            GoRoute(
              path: 'editProfile/:id',
              name: RouteName.editProfile,
              builder: (context, state) => EditProfilePage(
                id: state.pathParameters["id"]!,
                user: state.extra as User,
              ),
            )
          ]),
    ]);
