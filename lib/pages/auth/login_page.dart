import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/routes/router.dart';
import 'package:citchat/shared/custom_button.dart';
import 'package:citchat/shared/custom_form.dart';
import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  bool _isLoading = false;

  bool _emailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

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
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          CFormField(
                            isShowIcon: true,
                            icon: const Icon(Icons.mail),
                            controller: emailC,
                            title: "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This section can't be empty";
                              } else if (!_emailValid(value)) {
                                return "Email is not valid";
                              }   else {
                                return null;
                              }
                            },
                          ),
                          CFormField(
                            isShowIcon: true,
                            icon: const Icon(Icons.lock),
                            controller: passwordC,
                            title: "Password",
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This section can't be empty";
                              } else if (value.length < 6) {
                                return "Password must be 6 character";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CFillButton(
                              width: 120,
                              title: 'Sign In',
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthEventLogin(emailC.text, passwordC.text),
                                  );
                                  setState(() {
                                    _isLoading = true;
                                  });
                                }

                              },
                            ),
                          ),
                          BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthStateLogin) {
                                setState(() {
                                  _isLoading = false;
                                });
                                context.goNamed(RouteName.home);
                              } else if (state is AuthStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error, style: poppinsTextStyle))
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: const SizedBox(),
                          ),
                        ],
                      ),
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
            ),
            if (_isLoading) Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 6),
                    Text('Loading...', style: poppinsTextStyle,)
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
