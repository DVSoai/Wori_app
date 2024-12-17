import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wori_app/core/features/data/model/message/daily_question_model.dart';
import 'package:wori_app/core/features/data/model/message/message_model.dart';
import 'package:wori_app/core/features/domain/entities/message/daily_question_entity.dart';
import 'package:wori_app/core/features/domain/entities/message/message_entity.dart';
import 'package:http/http.dart' as http;

import '../../../../base/base_url.dart';

class MessagesRemoteDataSource {
  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
        Uri.parse('${EnvTestConstants.API_URL}/messages/$conversationId'),
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      try {
        List data = jsonDecode(response.body);
        return data.map((json) => MessageModel.fromJson(json)).toList();
      } catch (e) {
        debugPrint('conversationId: $conversationId');
        throw Exception('Failed to decode JSON: $e');
      }
    } else {
      throw Exception(
          'Failed to load messages. Status code: ${response.statusCode}');
    }
  }

  Future<DailyQuestionEntity> fetchDailyQuestion(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(
        Uri.parse(
            '${EnvTestConstants.API_URL}/conversations/$conversationId/daily-question'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      try {

        return DailyQuestionModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        debugPrint('conversationId: $conversationId');
        throw Exception('Failed to decode JSON: $e');
      }
    } else {
      throw Exception(
          'Failed to load question. Status code: ${response.statusCode}');
    }
  }
}
