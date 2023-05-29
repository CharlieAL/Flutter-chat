import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Usuario> usuarios = [
    Usuario(
        online: true,
        email: 'johndoe@example.com',
        nombre: 'John Doe',
        uid: 'uid1'),
    Usuario(
        online: false,
        email: 'janedoe@example.com',
        nombre: 'Jane Doe',
        uid: 'uid2'),
    Usuario(
        online: true,
        email: 'alexbrown@example.com',
        nombre: 'Alex Brown',
        uid: 'uid3'),
    Usuario(
        online: false,
        email: 'emilywilson@example.com',
        nombre: 'Emily Wilson',
        uid: 'uid4'),
    Usuario(
        online: true,
        email: 'michaelsmith@example.com',
        nombre: 'Michael Smith',
        uid: 'uid5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi Nombre',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
          color: Colors.black,
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 0, 253, 8),
            ),
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

  ListTile _usuariosListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(186, 0, 0, 0),
        child: Text(usuario.nombre.substring(0, 2)),
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
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
