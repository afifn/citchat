import 'package:citchat/shared/custom_button.dart';
import 'package:citchat/shared/custom_card_item.dart';
import 'package:citchat/shared/custom_form.dart';
import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final textSecond = Theme.of(context).colorScheme.secondary;
    final messageC = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Afifah',
              style: poppinsTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            Text(
              'online',
              style: poppinsTextStyle.copyWith(fontSize: 12, color: textSecond),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: listChat(context)),
          chatField(context, messageC)
        ],
      ),
    );
  }

  Widget listChat(BuildContext context) {
    return ListView(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: const [
        BubbleChatItem(
          message: "Nanti malam apakah ada acara?",
          photo: 'assets/images/avatar-3.jpg', isSender: true, time: '3:32pm',
        ),
        BubbleChatItem(
            message: "Tidak ada, apakah kamu mengajak aku keluar nanti malam?",
            photo: 'assets/images/avatar-2.jpg', isSender: false, time: '3:35pm'
        ),
        BubbleChatItem(
            message: "Iya nih, mau aku ajak keluar nanti malam, apakah kamu bisa?",
            photo: 'assets/images/avatar-3.jpg', isSender: true, time: '3:43pm'
        ),
        BubbleChatItem(
            message: "Iya, aku bisa?",
            photo: 'assets/images/avatar-2.jpg', isSender: false, time: '3:46pm'
        ),
        BubbleChatItem(
            message: "Oke nanti jam 7pm ketemuan di taman kota ya, sampai nanti malam?",
            photo: 'assets/images/avatar-3.jpg', isSender: true, time: '3:50pm'
        ),
        BubbleChatItem(
          message: "Afifah, Aku sudah sampai di taman kota, kamu di mana?",
          photo: 'assets/images/avatar-2.jpg', isSender: false,
          hasImage: true,
          image: 'assets/images/taman_kota.jpg',
          time: '7:03pm',
        ),
        BubbleChatItem(
          message: "Aku ada di sebelah utara danau",
          photo: 'assets/images/avatar-3.jpg', isSender: true,
          hasImage: true,
          image: 'assets/images/taman_kota2.webp',
          time: '7:04pm',
        ),
      ],
    );
  }

  Widget chatField(BuildContext context, TextEditingController messageC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: CIconButton(
                      icon: const Icon(Iconsax.add_circle),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: CFormChat(
                      hint: 'Type message...',
                      controller: messageC,
                      keyboardType: TextInputType.text,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          CIconButton(
            icon: const Icon(Iconsax.send_2),
            onPressed: () {
            },
          )
        ],
      ),
    );
  }
}
