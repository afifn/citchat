import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:citchat/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/chat_model.dart';
import '../../models/user_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore fstore = FirebaseFirestore.instance;
  final StreamController<List<UserWithChats>> _userStreamController = StreamController<List<UserWithChats>>.broadcast();

  Stream<QuerySnapshot<ChatModel>> streamChat(String groupChat) async* {
    yield* fstore
        .collection("message")
        .doc(groupChat)
        .collection(groupChat)
        .orderBy("timestamp", descending: true)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              ChatModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
  }

  Stream<List<UserWithChats>> streamUserChat() {
    return fstore.collection("users").snapshots().asyncMap((query) async {
      String groupChatId = "";
      List<User> users = [];
      List<UserWithChats> usersWithLastChat = [];
      String currentId = await Sp.storeDataString(Const.keyUid);

      for (DocumentSnapshot snapshot in query.docs) {
        User user = User.fromJson(snapshot.data() as Map<String, dynamic>);
        if (user.uid != currentId) {
          users.add(user);
          if (currentId.compareTo(user.uid) < 0) {
            groupChatId = '$currentId-${user.uid}';
          } else {
            groupChatId = '${user.uid}-$currentId';
          }
          log(groupChatId);
          QuerySnapshot chatSnapshot = await fstore
              .collection("message")
              .doc(groupChatId)
              .collection(groupChatId)
              .orderBy("timestamp", descending: true)
              .limit(1)
              .get();

          List<ChatModel> chats = chatSnapshot.docs.map((chatDoc) =>
              ChatModel.fromJson(chatDoc.data() as Map<String, dynamic>)).toList();
          if (chats.isNotEmpty) {
            UserWithChats userWithLastChat = UserWithChats(user: user, chats: chats.isNotEmpty ? chats.first : null);
            usersWithLastChat.add(userWithLastChat);
          }
        }
      }
      return usersWithLastChat;
    });
  }

  Stream<List<UserWithChats>> streamMessage() {
    _fetchUsersWithLastChat();

    Stream<QuerySnapshot> messagesStream = fstore.collection("messages").snapshots();
    messagesStream.listen((_) {
      _fetchUsersWithLastChat();
    });
    return _userStreamController.stream;
  }


  void _fetchUsersWithLastChat() async {
    String uid = await Sp.storeDataString(Const.keyUid);
    List<User> users = [];
    List<UserWithChats> userWithChats = [];
    String groupChatId = "";

    QuerySnapshot userSnapshot = await fstore.collection("users").get();
    for (DocumentSnapshot doc in userSnapshot.docs) {
      User user = User.fromJson(doc.data() as Map<String, dynamic>);
      if (user.uid != uid) {
        users.add(user);
      }
    }
    for (User user in users) {
      if (uid.compareTo(user.uid) < 0) {
        groupChatId = '$uid-${user.uid}';
      } else {
        groupChatId = '${user.uid}-$uid';
      }
      QuerySnapshot chatSnapshot = await fstore
          .collection("message")
          .doc(groupChatId)
          .collection(groupChatId)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get();

      List<ChatModel> chats = chatSnapshot.docs.map((chatDoc) =>
          ChatModel.fromJson(chatDoc.data() as Map<String, dynamic>)).toList();
      if (chats.isNotEmpty) {
        UserWithChats userWithLastChat = UserWithChats(user: user, chats:  chats.first);
        userWithChats.add(userWithLastChat);
      }
    }
    _userStreamController.add(userWithChats);
  }

  ChatBloc() : super(ChatInitial()) {
    on<ChatEventSending>((event, emit) {
      try {
        emit(ChatStateLoading());
        final DocumentReference ref = fstore
            .collection("message")
            .doc(event.groupId)
            .collection(event.groupId!)
            .doc(DateTime.now().millisecondsSinceEpoch.toString());
        ref
            .set({
              "idFrom": event.idForm,
              "idTo": event.idTo,
              "content": event.content,
              "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
              "type": event.type
            })
            .then((value) => debugPrint('success send message'))
            .onError((error, stackTrace) =>
                debugPrint("failed send message $error"));
        emit(ChatStateSuccess());
      } catch (e) {
        emit(ChatStateError(e.toString()));
      }
    });
  }
}
