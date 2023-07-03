import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/models/chat_model.dart';
import 'package:citchat/models/user_model.dart' as UserModel;
import 'package:citchat/shared/custom_card_item.dart';
import 'package:citchat/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../shared/custom_form.dart';


class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String currentId = "";
  String groupChatId = "";

  @override
  void initState() {
    _getCurrentId();
    super.initState();
  }

  Future<void> _getCurrentId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentId = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    ChatBloc chatBloc = context.read<ChatBloc>();

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
      body: StreamBuilder<List<UserModel.UserWithChats>>(
        stream: chatBloc.streamMessage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserModel.UserWithChats> userWithChats = snapshot.data!;
            return ListView.builder(
              itemCount: userWithChats.length,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (BuildContext context, int index) {
                UserModel.UserWithChats userWithChat = userWithChats[index];
                UserModel.User user = userWithChat.user;
                ChatModel? chats = userWithChat.chats;
                return MessageCardItem(
                  name: user.name,
                  photo: user.photo,
                  message: chats != null ? chats.content : "",
                  time: '3:32 pm',
                  isOnline: user.isOnline,
                  onPressed: () {
                    if (currentId.compareTo(user.uid) < 0) {
                      groupChatId = '$currentId-${user.uid}';
                    } else {
                      groupChatId = '${user.uid}-$currentId';
                    }
                    print(groupChatId);
                  },
                );
              },
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Tidak dapat mengambil data"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
