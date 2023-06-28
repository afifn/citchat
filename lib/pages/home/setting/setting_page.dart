import 'package:citchat/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/custom_form.dart';
import '../../../shared/theme.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    int _currentIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile' ,style: poppinsTextStyle.copyWith(fontWeight: medium),),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        children: [
          Row(
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/ava.jpg"))
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gegamlah tanganku ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: monsterratTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),),
                    Text('data', style: monsterratTextStyle.copyWith(fontSize: 14),)
                  ],
                ),
              ),
              CIconButton(
                icon: const Icon(Iconsax.edit),
                onPressed: () {

                },
              )
            ],
          )
        ],
      ),
    );
  }
}
