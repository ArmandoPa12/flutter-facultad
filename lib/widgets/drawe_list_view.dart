import 'package:facultad/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerListView extends StatelessWidget {
  const DrawerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Usuario'),
          onTap: () {
            Navigator.pushNamed(context, '/usuario');
          },
        ),
        // ListTile(
        //   title: const Text('Permisos'),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/permissions');
        //   },
        // ),
        ListTile(
          title: const Text('Roles'),
          onTap: () {
            Navigator.pushNamed(context, '/rol');
          },
        ),
        // ListTile(
        //   title: const Text('Horario'),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/schedule');
        //   },
        // ),
        // ListTile(
        //   title: const Text('Asistencia'),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/attendance');
        //   },
        // ),
        // ListTile(
        //   title: const Text('Lista'),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/list');
        //   },
        // ),
        ListTile(
          title: const Text('Inventario'),
          onTap: () {
            Navigator.pushNamed(context, '/ubicacion-articulo');
          },
        ),
        ListTile(
          title: const Text('Orden de Produccion'),
          onTap: () {
            Navigator.pushNamed(context, '/orden-produccion');
          },
        ),
        ListTile(
          title: const Text('Orden de Compra'),
          onTap: () {
            Navigator.pushNamed(context, '/orden-compra');
          },
        ),
        ListTile(
          title: const Text('Cerrar sesión'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        )
      ],
    );
  }
}
