part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}
class ChatEventSending extends ChatEvent {
  final String? groupId;
  final String content;
  final String idForm;
  final String idTo;
  final String? timestamp;
  final int type;
  ChatEventSending({
    required this.content,
    required this.idForm,
    required this.idTo,
    this.timestamp,
    required this.type,
    this.groupId
  });
}