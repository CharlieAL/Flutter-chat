import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late User usuarioPara;

  Future<List<Message>> getChat(String usuarioID) async {
    var url = Uri.parse('${Environment.apiUrl}/messages/$usuarioID');
    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      },
    );

    final mensajesResponse = mensajesResponseFromJson(resp.body);

    // print(mensajesResponse.messages[0].createdAt);

    return mensajesResponse.messages;
  }
}
