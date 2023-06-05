import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuariosService = UsuariosService();

  List<User> usuarios = [];

  @override
  void initState() {
    // TODO: implement initState
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
            socketService.disconnect();
          },
          icon: const Icon(Icons.close),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: socketService.serverStatus == ServerStatus.online
                ? const Icon(Icons.check_circle, color: Colors.blue)
                : const Icon(Icons.signal_wifi_bad, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: const WaterDropHeader(
          complete: Icon(Icons.check, color: Color.fromARGB(255, 3, 208, 0)),
          waterDropColor: Color.fromARGB(255, 0, 0, 0),
        ),
        child: _listviewUsuarios(),
      ),
    );
  }

  ListView _listviewUsuarios() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _usuariosListTile(usuarios[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuariosListTile(User usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(186, 0, 0, 0),
        child: Text(usuario.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online
                ? const Color.fromARGB(255, 1, 199, 11)
                : const Color.fromARGB(255, 255, 0, 0),
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    usuarios = await usuariosService.getUsuarios();
    setState(() {});
    // await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
