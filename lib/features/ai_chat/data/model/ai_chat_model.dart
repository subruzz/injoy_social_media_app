// import '../../domain/enitity/ai_chat_entity.dart';

// class ChatPartModel {
//   final String text;

//   ChatPartModel({required this.text});

//   factory ChatPartModel.fromJson(Map<String, dynamic> json) {
//     return ChatPartModel(
//       text: json['text'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'text': text,
//     };
//   }
// }

// class AiChatModel extends AiChatEntity {
//   AiChatModel({required super.role, required List<ChatPartModel> super.parts});

//   factory AiChatModel.fromJson(Map<String, dynamic> json) {
//     return AiChatModel(
//       role: json['role'] as String,
//       parts: (json['parts'] as List<dynamic>?)
//               ?.map((part) => ChatPartModel.fromJson(part as Map<String, dynamic>))
//               .toList() ??
//           [], 
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'role': role,
//       'parts': parts  .map((part) => part.toJson()).toList(),
//     };
//   }
// }