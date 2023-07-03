import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:citchat/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseFirestore fStore = FirebaseFirestore.instance;
  final FirebaseStorage fStorage = FirebaseStorage.instance;

  Stream<User> streamUserProfile() async* {
    final String uid = await Sp.storeDataString(Const.keyUid);
    yield* fStore
        .collection("users")
        .doc(uid)
        .withConverter<User>(
          fromFirestore: (snapshot, options) => User.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.data()!);
  }
  Stream<User> streamUserStatus(String uid) async* {
    yield* fStore.collection("users").doc(uid)
        .withConverter<User>(fromFirestore: (snapshot, options) => User.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
    ).snapshots().map((event) => event.data()!);
  }

  UserBloc() : super(UserStateInitial()) {
    on<UserEventUpdate>((event, emit) async {
      final String uid = await Sp.storeDataString(Const.keyUid);
      try {
        emit(UserStateLoading());
        final DocumentReference ref = fStore.collection("users").doc(uid);
        ref
            .update({
              'updated_at': DateTime.now(),
              'name': event.name,
            })
            .then((value) => debugPrint('Successfully update'))
            .onError(
                (error, stackTrace) => debugPrint("failed update data $error"));

        emit(UserStateSuccess("Successfully update profile"));
      } catch (e) {
        emit(UserStateError(e.toString()));
      }
    });

    on<UserEventUpdatePhoto>((event, emit) async {
      try {
        emit(UserStateLoading());
        final String uid = await Sp.storeDataString(Const.keyUid);
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef = fStorage.ref().child("images/$fileName");
        final uploadTask = storageRef.putFile(event.photo);

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        final DocumentReference ref = fStore.collection("users").doc(uid);
        ref
            .update({
              'updated_at': DateTime.now(),
              'photo': downloadUrl,
            })
            .then((value) => debugPrint('Successfully update'))
            .onError(
                (error, stackTrace) => debugPrint("failed update data $error"));

        emit(UserStateSuccess("Successfully update photo"));
      } catch (e) {
        emit(UserStateError("Update failed"));
      }
    });

    on<UserEventOnline>((event, emit) async {
      try {
        emit(UserStateLoading());
        final String uid = await Sp.storeDataString(Const.keyUid);
        final DocumentReference ref = fStore.collection("users").doc(uid);
        ref
            .update({
              'isOnline': event.isOnline,
            })
            .then((value) => debugPrint("user is ${event.isOnline}"))
            .onError((error, stackTrace) => debugPrint("set data user $error"));
        emit(UserStateOnline());
      } catch (e) {
        emit(UserStateError(e.toString()));
      }
    });
  }
}
