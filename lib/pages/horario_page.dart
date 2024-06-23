import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';

class HorarioPage extends StatelessWidget {
  const HorarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horario')),
      drawer: Drawer(child: DrawerListView()),
      body: const Center(child: Text('Página de Horarios')),
    );
  }
}
