import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';

class PermisosPage extends StatelessWidget {
  const PermisosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permisos')),
      drawer: DrawerListView(),
      body: const Center(child: Text('Página de Permisos')),
    );
  }
}
