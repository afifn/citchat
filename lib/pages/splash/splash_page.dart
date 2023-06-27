import 'dart:async';

import 'package:citchat/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:citchat/shared/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      context.goNamed(RouteName.onboarding);
    });

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
