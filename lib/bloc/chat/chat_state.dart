part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatStateLoading extends ChatState {}
class ChatStateSending extends ChatState {}

class ChatStateSuccess extends ChatState {}
class ChatStateError extends ChatState {
  ChatStateError(this.error);
  final String error;
}