import 'package:chat/services/socket_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  void initState() {
    // SocketService socketService =
    //     Provider.of<SocketService>(context, listen: false);
    // socketService.connect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    print(socketService.serverStatus);
    return Scaffold(
        body: Center(
          child: Text('Hola Mundo'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            socketService.socket.emit(
                'mensaje-personal', {'mensaje': 'Hola desde Por fin te quedo'});
          },
          child: const Icon(Icons.message),
        ));
  }
}
