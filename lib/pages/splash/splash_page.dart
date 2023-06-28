import 'dart:async';

import 'package:citchat/routes/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:citchat/shared/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _cekLogin();
    super.initState();
  }

  Future<void> _cekLogin() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      debugPrint(user.email);
      Timer(const Duration(seconds: 2), () {
        context.goNamed(RouteName.home);
      });
    } else{
      Timer(const Duration(seconds: 2), () {
        context.goNamed(RouteName.onBoarding);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('CitChat', style: GoogleFonts.montserrat(color: textColor).copyWith(fontSize: 20, fontWeight: bold))
          ],
        ),
      ),
    );
  }
}
