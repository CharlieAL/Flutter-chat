import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _message = [];

  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                maxRadius: 16,
                child: Text(
                  'Te',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Melissa Flores',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, i) => _message[i],
                  itemCount: _message.length,
                  reverse: true,
                ),
              ),
              SizedBox(
                height: 80,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  SafeArea _inputChat() => SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Flexible(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 242, 242, 242),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color.fromARGB(255, 217, 217, 217),
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: TextField(
                autocorrect: false,
                textInputAction: TextInputAction.send,
                onSubmitted: _handleSubmit,
                onChanged: (text) {
                  setState(() {
                    if (text.trim().isNotEmpty) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                keyboardType: TextInputType.text,
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Enviar mensaje',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                focusNode: _focusNode,
              ),
            )),
            // Botón de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: _estaEscribiendo
                        ? Color.fromARGB(255, 38, 223, 243)
                        : const Color.fromARGB(255, 242, 242, 242),
                    borderRadius: BorderRadius.circular(100)),
                child: IconTheme(
                  data: const IconThemeData(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(textController.text.trim())
                        : null,
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            )
          ],
        ),
      ));
  _handleSubmit(String value) {
    if (value.isEmpty) return;

    _focusNode.requestFocus();
    textController.clear();
    final newMessage = ChatMessage(
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
      texto: value,
      uid: '123',
    );
    _message.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // TODO: off del socket
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
