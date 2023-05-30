import 'dart:convert';
import 'package:chat/models/register_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  late User usuario;

  bool _autenticando = false;

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };
    var url = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      usuario = registerResponse.user;

      await _saveToke(registerResponse.token);
      autenticando = false;
      return true;
    } else {
      autenticando = false;
      return false;
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    autenticando = true;
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    var url = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    // print(resp.body);
    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      // print(registerResponse);
      usuario = registerResponse.user;

      await _saveToke(registerResponse.token);
      autenticando = false;
      return true;
    } else {
      autenticando = false;
      final errors = errorsFromJson(resp.body);
      // print(errors.msg);
      return errors.msg;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    var url = Uri.parse('${Environment.apiUrl}/login/renew');

    final resp = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString(),
      },
    );
    if (resp.statusCode == 200) {
      final registerResponse = loginResponseFromJson(resp.body);
      usuario = registerResponse.user;

      await _saveToke(registerResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToke(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
