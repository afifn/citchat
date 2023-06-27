import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/custom_button.dart';
import '../../shared/custom_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorBackground = Theme.of(context).colorScheme.onSecondary;
    final nameC = TextEditingController();
    final emailC = TextEditingController();
    final passwordC = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 72),
            Text('Create Account', style: monsterratTextStyle.copyWith(fontWeight: bold, fontSize: 18),),
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
                    icon: const Icon(Icons.person),
                    controller: nameC, title: "Full name",
                  ),
                  CFormField(
                    isShowIcon: true,
                    icon: const Icon(Icons.mail),
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
                      title: 'Sign Up',
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have a account?'),
                CTextButton(
                  width: 80,
                  title: 'Sign in', onPressed: () {
                  context.pop();
                },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
