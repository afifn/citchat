import 'package:citchat/routes/router.dart';
import 'package:citchat/shared/custom_card_item.dart';
import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/custom_form.dart';


class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Message', style: poppinsTextStyle.copyWith(fontWeight: medium),),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: CFormField(
                controller: searchC,
                isShowTitle: false,
                isShowIcon: true,
                title: "Search chat",
                icon: const Icon(Iconsax.message_search),
              ),
            ),
          ],
        )
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [

          MessageCardItem(
            name: 'Afifah',
            photo: "assets/images/avatar-3.jpg",
            message: 'Nanti malam apakah kamu ada acara?',
            time: '3:32 pm',
            isOnline: true,
            onPressed: () {
              context.goNamed(RouteName.chat);
            },
          ),
          const MessageCardItem(
            name: 'Anisa',
            photo: "assets/people3.png",
            message: 'Selamat siang',
            time: '2:20 pm',
          ),
          const MessageCardItem(
            name: 'Udin Sadboy',
            photo: "assets/people2.png",
            message: 'Halo kawan, apa kabar apakah kamu baik-baik saja?, aku disini baik-baik saja',
            time: '2:30 pm',
            isOnline: true,
          ),
          const MessageCardItem(
            name: 'Tata Sinaga',
            photo: "assets/people4.png",
            message: 'Selamat pagi mas bro',
            time: '8:24 am',
          ),

          const MessageCardItem(
            name: 'Yumi\'s ',
            photo: "assets/images/avatar-5.jpg",
            message: 'Watashi waaaa',
            time: '6:19 am',
          ),const MessageCardItem(
            name: 'Yumi\'s ',
            photo: "assets/images/avatar-5.jpg",
            message: 'Watashi waaaa',
            time: '6:19 am',
          ),const MessageCardItem(
            name: 'Yumi\'s ',
            photo: "assets/images/avatar-5.jpg",
            message: 'Watashi waaaa',
            time: '6:19 am',
          ),const MessageCardItem(
            name: 'Yumi\'s ',
            photo: "assets/images/avatar-5.jpg",
            message: 'Watashi waaaa',
            time: '6:19 am',
          ),

        ],
      ),
    );
  }
}
