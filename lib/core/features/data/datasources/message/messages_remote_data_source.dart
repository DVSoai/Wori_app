import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wori_app/core/features/data/model/message/message_model.dart';
import 'package:wori_app/core/features/domain/entities/message/message_entity.dart';
import 'package:http/http.dart' as http;

class MessagesRemoteDataSource {
  final String baseUrl = 'http://192.168.2.7:3000';

  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http
        .get(Uri.parse('$baseUrl/messages/$conversationId'), headers: {
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200) {
      try {
        List data = jsonDecode(response.body);
        return data.map((json) => MessageModel.fromJson(json)).toList();
      } catch (e) {
        debugPrint('conversationId: $conversationId');
        throw Exception('Failed to decode JSON: $e');
      }
    } else {
      throw Exception('Failed to load messages. Status code: ${response.statusCode}');
    }
  }
}
