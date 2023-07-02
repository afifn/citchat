class ChatModel {
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  final int type;

  ChatModel({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        idFrom: json["idFrom"] ?? "",
        idTo: json["idTo"] ?? "",
        timestamp: json["timestamp"] ?? "",
        content: json["content"] ?? "",
        type: json["type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "idFrom": idFrom,
        "idTo": idTo,
        "timestamp": timestamp,
        "content": content,
        "type": type,
      };
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
