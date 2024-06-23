import 'package:facultad/models/permisos.dart';
import 'package:facultad/models/rol.dart';
import 'package:facultad/pages/CRUD/rol/rol_read.dart';
import 'package:facultad/service/permisos_service.dart';
import 'package:facultad/service/rol_service.dart';
import 'package:facultad/widgets/custom_text.dart';
import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';

class RolPage extends StatefulWidget {
  const RolPage({super.key});

  @override
  State<RolPage> createState() => _RolPageState();
}

class _RolPageState extends State<RolPage> {
  late Future<List<PermisosMrp>> futurePermisos;
  late Future<List<Rol>> futureRoles;

  final _permisosService = PermisosService();
  final _rolService = RolService();
  @override
  void initState() {
    super.initState();
    futureRoles = _rolService.get();
    futurePermisos = _permisosService.get();
    // futurePeriodos = _periodoServive.fecthPeriodo2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roles')),
      drawer: const Drawer(
        child: DrawerListView(),
      ),
      body: Column(
        children: [
          const Center(child: Text('Página de Roles')),
          Container(
              height: 400,
              child: FutureBuilder(
                  future: futureRoles,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No periods found'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final itemFuture = snapshot.data![index];
                          return ListTile(
                            title:
                                CustomText(labelText: '${itemFuture.nombre}'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RolRead(
                                            rol: itemFuture,
                                            nuevo: false,
                                          )));
                            },
                          );
                        },
                      );
                    }
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RolRead(
                        rol: Rol(
                          id: 0,
                          nombre: 'Nuevo Rol',
                          funcion: '',
                          responsabilidad: '',
                          permisos: [],
                        ),
                        nuevo: true,
                      )));
        },

        // _showInputDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
