import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'base/base_url.dart';
class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket _socket;
  final _storage = FlutterSecureStorage();

  SocketService._internal() {
    initSocket();
    }

    Future<void>initSocket() async {
      String? token = await _storage.read(key: 'token') ?? '';

      _socket = IO.io(EnvTestConstants.API_URL,IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build()
      );

      _socket.connect();


      _socket.onConnect((_) {
        print(' Socket connected: ${_socket.id}');
      });

      _socket.onDisconnect((_) {
        print('Socket disconnected');
      });
  }

  IO.Socket get socket => _socket;
}