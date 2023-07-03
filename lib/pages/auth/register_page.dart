import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/custom_button.dart';
import '../../shared/custom_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _keyForm = GlobalKey<FormState>();
  bool _isLoading = false;

  bool _emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final colorBackground = Theme.of(context).colorScheme.onSecondary;
    final nameC = TextEditingController();
    final emailC = TextEditingController();
    final passwordC = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 72),
                Text(
                  'Create Account',
                  style: monsterratTextStyle.copyWith(
                      fontWeight: bold, fontSize: 18),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: colorBackground,
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        CFormField(
                          isShowIcon: true,
                          icon: const Icon(Icons.person),
                          controller: nameC,
                          title: "Full name",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This section can't be empty";
                            } else {
                              return null;
                            }
                          },
                        ),
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
                            } else {
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
                            title: 'Sign Up',
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      AuthEventRegister(nameC.text, emailC.text,
                                          passwordC.text),
                                    );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have a account?'),
                    CTextButton(
                      width: 80,
                      title: 'Sign in',
                      onPressed: () {
                        context.pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Loading...',
                        style: poppinsTextStyle,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
              listener: (context, state) {
                if (state is AuthStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.error,
                              style: poppinsTextStyle,
                          ),
                      ),
                  );
                } else if (state is AuthStateSuccess) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.message,
                              style: poppinsTextStyle,
                          ),
                      ),
                  );
                }
              }
          )
        ],
      ),
    );
  }
}
