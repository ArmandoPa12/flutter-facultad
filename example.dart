import 'package:facultad/models/orden_produccion.dart';
import 'package:facultad/service/orden_produccion.dart';
import 'package:facultad/widgets/custom_text.dart';
import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';

class OrdenProduccionPage extends StatefulWidget {
  const OrdenProduccionPage({super.key});

  @override
  State<OrdenProduccionPage> createState() => _OrdenProduccionPageState();
}

class _OrdenProduccionPageState extends State<OrdenProduccionPage> {
  late Future<List<OrdenProduccion>> future;
  final _servicio = OrdenProduccionService();

  @override
  void initState() {
    super.initState();
    future = _servicio.get();
    // futureRoles = _rolService.get();
    // futurePermisos = _permisosService.get();
    // futurePeriodos = _periodoServive.fecthPeriodo2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('XXXXXXXXXXXXXX')),
      drawer: const Drawer(
        child: DrawerListView(),
      ),
      body: Column(
        children: [
          Container(
              height: 400,
              child: FutureBuilder(
                  future: future,
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
                                CustomText(labelText: '${itemFuture.userGen}'),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => RolRead(
                              //               rol: itemFuture,
                              //               nuevo: false,
                              //             )));
                            },
                          );
                        },
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
