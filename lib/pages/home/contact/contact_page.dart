import 'dart:convert';
import 'dart:math';

import 'package:citchat/shared/custom_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/custom_form.dart';
import '../../../shared/theme.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('People', style: poppinsTextStyle.copyWith(fontWeight: medium),),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: CFormField(
                controller: searchC,
                isShowTitle: false,
                isShowIcon: true,
                title: "Search people",
                icon: const Icon(Iconsax.sms_search),
              ),
            ),
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _listPeople()
          ],
        ),
      ),
    );
  }
  Widget _listPeople() {
    return Expanded(
      child: GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 16, mainAxisSpacing: 16, crossAxisCount: 2),
        children: const [
          CardPeopleItem(name: 'Afif', email: 'afif@mail.com', photo: ""),
          CardPeopleItem(name: 'Endank Soekamti Aninananan Endank Soekamti Aninananan', email: 'endankSoekamti@mail.com', photo: ""),

        ],
      ),
    );
  }
}
