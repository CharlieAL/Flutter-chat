import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  final List<ChatMessage> _message = [];

  bool _estaEscribiendo = false;

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService.usuarioPara.uid);
    super.initState();
  }

  void _cargarHistorial(String usuarioId) async {
    List<Message> chat = await chatService.getChat(usuarioId);

    print(chat[0].createdAt);

    final history = chat.map((m) => ChatMessage(
        texto: m.mensaje,
        uid: m.de,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));
    setState(() {
      _message.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {
    print(payload['mensaje']);
    ChatMessage message = ChatMessage(
      texto: payload['mensaje'],
      uid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 100)),
    );
    setState(() {
      _message.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                maxRadius: 16,
                child: Text(
                  usuarioPara.name.substring(0, 2),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                usuarioPara.name,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              )
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black87,
            ),
          ),
        ),
        body: Column(
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
                        ? const Color.fromARGB(255, 38, 223, 243)
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
      uid: authService.usuario.uid,
    );
    _message.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });

    socketService.socket.emit('mensaje-personal', {
      'de': authService.usuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': value
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
