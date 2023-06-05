import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;

  final AnimationController animationController;

  const ChatMessage(
      {super.key,
      required this.texto,
      required this.uid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero)
            .animate(animationController),
        child: FadeTransition(
          opacity: animationController,
          child: Container(
            child:
                uid == authService.usuario.uid ? _myMessage() : _notMyMessage(),
          ),
        ),
      ),
    );
  }

  _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 13, 139, 150),
            borderRadius: BorderRadius.circular(20)),
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 15),
        child: Text(
          texto,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 67, 67, 67),
            borderRadius: BorderRadius.circular(20)),
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 5, left: 15, right: 50),
        child: Text(
          texto,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
