import 'package:citchat/routes/router.dart';
import 'package:citchat/shared/custom_button.dart';
import 'package:citchat/shared/custom_form.dart';
import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorBackground = Theme.of(context).colorScheme.onSecondary;

    final emailC = TextEditingController();
    final passwordC = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login', style: monsterratTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                  Text(
                    'Please sign in to continue.',style: monsterratTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorBackground,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        CFormField(
                          isShowIcon: true,
                          icon: Icon(Icons.mail),
                          controller: emailC,
                          title: "Email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        CFormField(
                          isShowIcon: true,
                          icon: const Icon(Icons.lock),
                          controller: passwordC,
                          title: "Password",
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CFillButton(
                            width: 120,
                            title: 'Sign In',
                            onPressed: () {
                              context.goNamed(RouteName.home);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: monsterratTextStyle,
                  ),
                  CTextButton(
                    width: 80,
                    title: 'Sign up',
                    onPressed: () {
                      context.pushNamed(RouteName.register);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
