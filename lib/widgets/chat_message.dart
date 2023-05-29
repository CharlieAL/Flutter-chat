import 'package:flutter/material.dart';

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
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero)
            .animate(animationController),
        child: FadeTransition(
          opacity: animationController,
          child: Container(
            child: this.uid == '123' ? _myMessage() : _notMyMessage(),
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
            color: Colors.blue[400], borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 100, right: 15),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 5, left: 15, right: 100),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.black87, fontSize: 17),
        ),
      ),
    );
  }
}
