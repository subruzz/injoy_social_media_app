class AiChatEntity {
  final String role;
  final List<ChatPartModel> parts;
  final bool isWaitingForRes;

  AiChatEntity(
      {required this.role, required this.parts, this.isWaitingForRes = false});

  factory AiChatEntity.fromJson(Map<String, dynamic> json) {
    return AiChatEntity(
      role: json['role'] as String,
      parts: (json['parts'] as List<dynamic>)
          .map((item) => ChatPartModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'parts': parts.map((part) => part.toJson()).toList(),
    };
  }
}

class ChatPartModel {
  final String text;

  ChatPartModel({required this.text});

  factory ChatPartModel.fromJson(Map<String, dynamic> json) {
    return ChatPartModel(
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
