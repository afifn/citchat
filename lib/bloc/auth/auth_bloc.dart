import 'dart:async';

import 'package:bcrypt/bcrypt.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

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
  }
}
