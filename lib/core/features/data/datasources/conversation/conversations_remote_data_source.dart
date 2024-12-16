import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wori_app/core/features/data/model/conversation/conversation_model.dart';
import 'package:http/http.dart' as http;

class ConversationsRemoteDataSource {
  final String baseUrl = 'http://192.168.2.7:3000';

  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConversations() async {
    String token = await _storage.read(key: 'token') ?? '';

    final response =
        await http.get(Uri.parse('$baseUrl/conversations'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      try {
        List data = jsonDecode(response.body);
        return data.map((json) => ConversationModel.fromJson(json)).toList();
      } catch (e) {
        throw Exception('Failed to decode JSON: $e');
      }
    } else {
      throw Exception(
          'Failed to load conversations. Status code: ${response.statusCode}');
    }
  }

  Future<String> checkOrCreateConversation({required String contactId}) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.post(
        Uri.parse('$baseUrl/conversations/check-or-create'),
        body: jsonEncode({'contactId': contactId}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        return data['conversationId'];
      } catch (e) {
        throw Exception('Failed to decode JSON: $e');
      }
    } else {
      throw Exception(
          'Failed to check or create conversations. Status code: ${response.statusCode}');
    }
  }
}
