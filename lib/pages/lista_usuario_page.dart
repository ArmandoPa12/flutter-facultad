import 'package:facultad/models/usuario.dart';
import 'package:facultad/pages/usuarios_page.dart';
import 'package:facultad/service/usuario_service.dart';
import 'package:facultad/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ListaUsuario extends StatefulWidget {
  // final  rol;

  const ListaUsuario({super.key});

  @override
  State<ListaUsuario> createState() => _ListaUsuarioState();
}

class _ListaUsuarioState extends State<ListaUsuario> {
  late Future<List<Usuario>> futureUsuarios;
  // late Future<List<UsuarioService>> futureRoles;

  final _servicio = UsuarioService();

  @override
  void initState() {
    super.initState();
    futureUsuarios = _servicio.getLista();
    // futurePeriodos = _periodoServive.fecthPeriodo2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(labelText: 'Buscar usuario'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
            future: futureUsuarios,
            builder: (context, resultado) {
              if (resultado.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!resultado.hasData || resultado.data!.isEmpty) {
                return const Center(child: Text('No se encontro resultado'));
              } else {
                return ListView.builder(
                    itemCount: resultado.data!.length,
                    itemBuilder: ((context, index) {
                      final usuario = resultado.data![index];
                      return ListTile(
                        title: Text(
                            '${usuario.personaNombre} ${usuario.personaApellidoP} ${usuario.personaApellidoM}'),
                        subtitle: Text('Rol: ${usuario.rolNombre}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UsuarioListaPage(usuario: usuario)));
                        },
                      );
                    }));
              }
            })
// if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(child: Text('No periods found'));
//                     } else {
//                       return ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           final itemFuture = snapshot.data![index];
//                           return ListTile(
//                             title: Text('hola'),
//                           )});

        );
  }
}
