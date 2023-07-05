import 'package:chat/Screens/chat_screen.dart';
import 'package:chat/Screens/loading_screen.dart';
import 'package:chat/Screens/register_screen.dart';
import 'package:chat/Screens/watch_screent.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/Screens/usuarios_screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => const UsuariosScreen(),
  'chat': (_) => const ChatScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'loading': (_) => const LoadingScreen(),
  'watch': (_) => const WatchScreen(),
};
