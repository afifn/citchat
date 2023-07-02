import 'package:citchat/bloc/bloc.dart';
import 'package:citchat/models/chat_model.dart';
import 'package:citchat/models/user_model.dart';
import 'package:citchat/shared/custom_button.dart';
import 'package:citchat/shared/custom_card_item.dart';
import 'package:citchat/shared/custom_form.dart';
import 'package:citchat/shared/theme.dart';
import 'package:citchat/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatPage extends StatefulWidget {
  final String uid;
  final User user;
  const ChatPage({super.key, required this.uid, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _key = GlobalKey<FormState>();
  late String currentUid;
  late String groupChatId;

  @override
  void initState() {
    currentUid = "";
    groupChatId = "";
    _getCurrentUid();
    super.initState();
  }

  Future<void> _getCurrentUid() async {
    currentUid = await Sp.storeDataString(Const.keyUid);

    String uidFrom = widget.uid;
    setState(() {
      if (currentUid.compareTo(uidFrom) < 0) {
        groupChatId = '$currentUid-$uidFrom';
      } else {
        groupChatId = '$uidFrom-$currentUid';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textSecond = Theme.of(context).colorScheme.secondary;
    final messageC = TextEditingController();
    final ChatBloc chatBloc = context.read<ChatBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.user.name,
              style:
                  poppinsTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
            if (widget.user.isOnline)
              Text(
                "online",
                style:
                    poppinsTextStyle.copyWith(fontSize: 12, color: textSecond),
              ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: listChat(context, chatBloc)),
          chatField(context, messageC)
        ],
      ),
    );
  }

  Widget listChat(BuildContext context, ChatBloc chatBloc) {
    return StreamBuilder<QuerySnapshot<ChatModel>>(
        stream: chatBloc.streamChat(groupChatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Tidak dapat mengambil pesan'),
            );
          }
          List<ChatModel> listChat = [];
          for (var element in snapshot.data!.docs) {
            listChat.add(element.data());
          }
          if (listChat.isEmpty) {
            return const Center(
              child: Text("tidak ada pesan"),
            );
          }
          String millisecondsToTime(int milliseconds) {
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(milliseconds);
            String time =
                '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
            return time;
          }

          return ListView.builder(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemCount: listChat.length,
            itemBuilder: (BuildContext context, int index) {
              ChatModel chatModel = listChat[index];
              String time = millisecondsToTime(int.parse(chatModel.timestamp));
              return BubbleChatItem(
                message: chatModel.content,
                photo: widget.user.photo,
                isSender: (chatModel.idFrom == widget.user.uid),
                time: time,
              );
            },
          );
        });
  }

  Widget chatField(BuildContext context, TextEditingController messageC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Form(
        key: _key,
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
                if (_key.currentState!.validate()) {
                  if (messageC.text.isNotEmpty) {
                    context.read<ChatBloc>().add(
                          ChatEventSending(
                            content: messageC.text,
                            idForm: currentUid,
                            idTo: widget.user.uid,
                            type: 1,
                            groupId: groupChatId,
                          ),
                        );
                    messageC.clear();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
