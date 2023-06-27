import 'package:flutter/material.dart';

import '../../shared/theme.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting' ,style: poppinsTextStyle.copyWith(fontWeight: medium),),
      ),
      body: ListView(
        
      ),
    );
  }
}
