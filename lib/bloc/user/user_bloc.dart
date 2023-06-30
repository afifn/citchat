import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citchat/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseFirestore fStore = FirebaseFirestore.instance;

  Stream<User> streamUserProfil() async*{
    final String uid = await Sp.storeDataString(Const.keyUid);
    yield* fStore
        .collection("users")
        .doc(uid)
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    ).snapshots().map((snapshot) => snapshot.data()!);
  }

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {

    });
  }
}
