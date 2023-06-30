import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citchat/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitialize()) {
    FirebaseAuth fAuth = FirebaseAuth.instance;
    FirebaseFirestore fStore = FirebaseFirestore.instance;

    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());

        await fAuth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        User? user = fAuth.currentUser;
        Sp.saveDataString(Const.keyUid, user!.uid);
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(error: e.message.toString()));
      } catch (e) {
        emit(AuthStateError(error: e.toString()));
      }
    });

    on<AuthEventRegister>((event, emit) async {
      try {
        emit(AuthStateLoading());
        final createUser = await fAuth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        final DocumentReference ref = fStore.collection("users").doc(createUser.user?.uid);
        ref.set({
          'uid': createUser.user?.uid,
          'name': event.name,
          'email': event.email,
        })
            .then((value) => debugPrint("success create account"))
            .onError((error, stackTrace) =>
            debugPrint("Failed to add user: $error"));
        emit(AuthStateSuccess("Successfully created user"));
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(error: e.message.toString()));
      } catch (e) {
        emit(AuthStateError(error: e.toString()));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      try {
        emit(AuthStateLoading());
        Sp.removeData(Const.keyUid);
        fAuth.signOut();
        emit(AuthStateSuccess("Sign out success"));
      } on FirebaseException catch (e) {
        emit(AuthStateError(error: e.message.toString()));
      } catch (e) {
        emit(AuthStateError(error: e.toString()));
      }
    });
  }
}
