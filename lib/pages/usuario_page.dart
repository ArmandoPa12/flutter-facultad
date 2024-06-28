import 'package:facultad/models/usuario.dart';
import 'package:facultad/pages/lista_usuario_page.dart';
import 'package:facultad/service/usuario_service.dart';
import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facultad/providers/user_provider.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  late Future<Usuario> futureUsuario;
  final _servicio = UsuarioService();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    futureUsuario = _servicio.get(user!.userId);
  }

  // UserProfileWidget({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    // Future<Usuario> actual = _servicio.get(user!.userId);

    return Scaffold(
      appBar: AppBar(title: const Text('Usuario')),
      drawer: const Drawer(
        child: DrawerListView(),
      ),
      body: FutureBuilder<Usuario>(
        future: futureUsuario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          } else {
            final usuario = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        usuario.imagen), // Aquí cargas la imagen desde la URL
                  ),
                  SizedBox(height: 20),
                  // const SizedBox(
                  //   height: 150,
                  //   child: Center(
                  //     child: Icon(
                  //       Icons.account_circle_outlined,
                  //       size: 150,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 8),
                  ListTile(
                    // leading: Icon(Icons.person),
                    title: Text('Nombre: ${usuario.personaNombre}',
                        style: const TextStyle(fontSize: 18)),
                    subtitle: Text(
                        'Apellidos: ${usuario.personaApellidoP} ${usuario.personaApellidoM}',
                        style: const TextStyle(fontSize: 15)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.security_sharp),
                    title: Text(usuario.rolNombre,
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text('Correo: ${usuario.personaNombre}',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone_android_sharp),
                    title: Text('Telefono: ${usuario.celular}',
                        style: const TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListaUsuario()));
        },
        child: const Icon(Icons.search_rounded),
      ),
    );
  }
}
