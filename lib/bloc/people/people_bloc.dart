import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';
import '../../utils/shared_preferences.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final FirebaseFirestore fStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<User>> streamPeople() async* {
    final String uid = await Sp.storeDataString(Const.keyUid);
    yield* fStore
        .collection("users")
        .where("uid", isNotEqualTo: uid)
        .withConverter<User>(
        fromFirestore: (snapshot, options) => User.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
    ).snapshots();
  }

  PeopleBloc() : super(PeopleInitial()) {
    on<PeopleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
