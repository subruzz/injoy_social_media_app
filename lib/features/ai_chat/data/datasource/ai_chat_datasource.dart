import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/ai_chat/domain/enitity/ai_chat_entity.dart';

abstract interface class AiChatDatasource {
  Future<String> sendAndGetChat(List<AiChatEntity> prevMessages, String query);
}

class AiChatDatasourceImpl implements AiChatDatasource {
  @override
  Future<String> sendAndGetChat(
      List<AiChatEntity> prevMessages, String query) async {
    try {
      String apiKey = dotenv.env['GEMINI_API_KEY']!;
      final res = await http.post(
          Uri.parse(
              'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode({
            "contents": prevMessages.map((e) => e.toJson()).toList(),
            "generationConfig": {
              "temperature": 1,
              "topK": 64,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "responseMimeType": "text/plain",
              "stopSequences": [],
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE",
              },
            ]
          }));
      log(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Parse the response body as JSON
        final responseJson = jsonDecode(res.body) as Map<String, dynamic>;

        // Extract the content from the response
        final candidates = responseJson['candidates'] as List<dynamic>? ?? [];
        final content = candidates.isNotEmpty
            ? (candidates.first as Map<String, dynamic>)['content']
                    as Map<String, dynamic>? ??
                {}
            : {};
        final parts = content['parts'] as List<dynamic>? ?? [];

        final text = parts.isNotEmpty
            ? (parts.first as Map<String, dynamic>)['text'] as String? ?? ''
            : '';

        return text;
      } else {
        log('Error while sending');
        throw const MainException();
      }
    } catch (e) {
      log('Errpor is ${e.toString()}');
      throw const MainException();
    }
  }
}
