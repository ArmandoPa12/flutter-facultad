import 'package:facultad/models/ubicacion_articulo.dart';
import 'package:facultad/pages/CRUD/ubicacion_articulo/ubicacion_articulo_read.dart';
import 'package:facultad/service/ubicacion_articulo_service.dart';
import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';

class UbicacionArticuloPage extends StatefulWidget {
  const UbicacionArticuloPage({super.key});

  @override
  State<UbicacionArticuloPage> createState() => _UbicacionArticuloPageState();
}

class _UbicacionArticuloPageState extends State<UbicacionArticuloPage> {
  late Future<List<UbicacionArticulo>> futureUbicaciones;
  final _servicio = UbicacionArticuloService();

  @override
  void initState() {
    super.initState();
    futureUbicaciones = _servicio.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      drawer: const Drawer(
        child: DrawerListView(),
      ),
      body: Column(
        children: [
          // const Center(child: Text('Página de Roles')),
          Container(
              height: 400,
              child: FutureBuilder(
                  future: futureUbicaciones,
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
                            title: Text(itemFuture.nombre),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Stock: ${itemFuture.cantArticulo}')
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UbicacionArticuloRead(
                                              articulo: itemFuture)));
                            },
                          );
                        },
                      );
                    }
                  })),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print('crear elemento');
      //     // Navigator.push(
      //     //     context,
      //     //     MaterialPageRoute(
      //     //         builder: (context) => RolRead(
      //     //               rol: Rol(
      //     //                 id: 0,
      //     //                 nombre: 'Nuevo Rol',
      //     //                 funcion: '',
      //     //                 responsabilidad: '',
      //     //                 permisos: [],
      //     //               ),
      //     //               nuevo: true,
      //     //             )));
      //   },

      //   // _showInputDialog,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
