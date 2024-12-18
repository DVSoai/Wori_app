import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../base/base_url.dart';
import '../../model/contacts/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactRemoteDataSource {

  final _storage = FlutterSecureStorage();

  Future<List<ContactModel>> fetchContacts()async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(Uri.parse('${EnvTestConstants.API_URL}/contacts'),
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

    final response = await http.post(Uri.parse('${EnvTestConstants.API_URL}/contacts'),
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
  Future<List<ContactModel>>fetchRecentContacts()async {
    debugPrint('step : -1');
    String token = await _storage.read(key: 'token') ?? '';

    final response = await http.get(Uri.parse('${EnvTestConstants.API_URL}/contacts/recent'),
        headers: {
          'Authorization': 'Bearer $token',
        }
    );
    debugPrint('step : 0');
    if(response.statusCode == 201){
      debugPrint('step :1');
      try{
        debugPrint('step :2');
        List data = jsonDecode(response.body);
        debugPrint('step :3');
        debugPrint(data.toList().toString());
        return data.map((json) => ContactModel.fromJson(json)).toList();
      }catch(e){
        throw Exception('Failed to decode JSON: $e');
      }
    }else{
      throw Exception('Failed to load recent contacts Status code: ${response.statusCode}');
    }
  }
}
