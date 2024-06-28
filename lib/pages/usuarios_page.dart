import 'package:facultad/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioListaPage extends StatefulWidget {
  final Usuario usuario;

  const UsuarioListaPage({super.key, required this.usuario});

  @override
  State<UsuarioListaPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioListaPage> {
  late Future<Usuario> futureUsuario;

  // @override
  // void initState() {
  //   super.initState();
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final user = userProvider.user;
  //   futureUsuario = _servicio.get(user!.userId);
  // }

  @override
  Widget build(BuildContext context) {
    String? imageUrl = widget.usuario.imagen;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Usuario')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUrl != null && Uri.parse(imageUrl).isAbsolute
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(imageUrl),
                    )
                  : SizedBox(
                      height: 150,
                      child: Center(
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 150,
                        ),
                      ),
                    ),
              SizedBox(height: 8),
              ListTile(
                // leading: Icon(Icons.person),
                title: Text('Nombre: ${widget.usuario.personaNombre}',
                    style: const TextStyle(fontSize: 18)),
                subtitle: Text(
                    'Apellidos: ${widget.usuario.personaApellidoP} ${widget.usuario.personaApellidoM}',
                    style: const TextStyle(fontSize: 15)),
              ),
              ListTile(
                leading: const Icon(Icons.security_sharp),
                title: Text(widget.usuario.rolNombre,
                    style: const TextStyle(fontSize: 18)),
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text('Correo: ${widget.usuario.correo}',
                    style: const TextStyle(fontSize: 18)),
              ),
              ListTile(
                leading: const Icon(Icons.phone_android_sharp),
                title: Text('Telefono: ${widget.usuario.celular}',
                    style: const TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ));
  }
}
