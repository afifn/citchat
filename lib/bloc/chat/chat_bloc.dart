import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/chat_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore fstore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<ChatModel>> streamChat(String groupChat) async* {
    print("group chat $groupChat");
    yield* fstore
        .collection("message")
        .doc(groupChat)
        .collection(groupChat)
        .orderBy("timestamp", descending: true)
        .withConverter(
        fromFirestore: (snapshot, options) => ChatModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
    ).snapshots();
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
        ref.set({
          "idFrom": event.idForm,
          "idTo": event.idTo,
          "content": event.content,
          "timestamp": DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          "type": event.type
        })
            .then((value) => debugPrint('success send message'))
            .onError((error, stackTrace) =>
            debugPrint("failed send message $error"));
        emit(ChatStateSuccess());
      } catch (e){
        emit(ChatStateError(e.toString()));
      }
    });
  }
}
