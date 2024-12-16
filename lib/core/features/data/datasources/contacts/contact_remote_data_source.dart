import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/contacts/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactRemoteDataSource {
  final String baseUrl = 'http://192.168.2.7:3000';
  final _storage = FlutterSecureStorage();

  Future<List<ContactModel>> fetchContacts()async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(Uri.parse('$baseUrl/contacts'),
    headers: {
      'Authorization': 'Bearer $token',
    }
    );
    if(response.statusCode == 200){
      try{
        List data = jsonDecode(response.body);
        return data.map((json) => ContactModel.fromJson(json)).toList();
      }catch(e){
        throw Exception('Failed to decode JSON: $e');
      }
    }else{
      throw Exception('Failed to load contacts Status code: ${response.statusCode}');
    }
  }
  Future<void> addContact({required String email}) async {
    final String token = await _storage.read(key: 'token') ?? '';

    final response = await http.post(Uri.parse('$baseUrl/contacts'),
        body: jsonEncode({
          'contactEmail': email,
        }),
        headers: {
        'Content-Type':'application/json',
          'Authorization':'Bearer $token',
        });
    if(response.statusCode != 201){
      throw Exception('Failed to add contact. Status code: ${response.statusCode}');
    }
  }
}
