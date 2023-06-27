import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../shared/theme.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    final List<Message> _messages = [];

    return Scaffold(
      appBar: AppBar(

        title: Text('People', style: poppinsTextStyle.copyWith(fontWeight: medium),),
      ),
      body: Container(),
    );
  }
}

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}