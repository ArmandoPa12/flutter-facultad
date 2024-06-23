import 'package:facultad/models/periodo.dart';
import 'package:facultad/service/periodo_service.dart';
import 'package:facultad/widgets/custom_text_field.dart';
import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  late Future<List<Permisos>> futurePeriodos;
  final _periodoServive = PeriodoService();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _editarnombreController = TextEditingController();
  int? _editingId;

  @override
  void initState() {
    super.initState();
    futurePeriodos = _periodoServive.fecthPeriodo2();
  }

  void getDatos() {
    setState(() {
      futurePeriodos = _periodoServive.fecthPeriodo2();
    });
  }

  void save() async {
    final nombre = _nombreController.text;
    final periodo = await _periodoServive.postPeriodo(nombre);

    print(periodo);
    if (periodo != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Periodo guardado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        print('Error');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hubo un error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Periodo'),
          content: CustomTextField(
              controllerEdit: _nombreController,
              labelText: 'Ingrese nombre del periodo'),
          // content: TextField(
          //   onChanged: (value) {
          //     inputText = value;
          //   },
          //   decoration: InputDecoration(hintText: "Ingrese nombre del periodo"),
          // ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                save();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                // Aquí puedes manejar el valor ingresado
                save();
                print('Periodo ingresado: ${_nombreController.text}');
                getDatos();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void update() async {
    final nombre = _editarnombreController.text;
    if (_editingId != null) {
      print('boton update ' + _editingId.toString() + nombre);
      final updated = await _periodoServive.put(_editingId!, nombre);
      if (updated != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Periodo actualizado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
        getDatos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hubo un error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showEditDialog(int id, String currentName) {
    _editarnombreController.text = currentName;
    _editingId = id;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Periodo'),
          content: CustomTextField(
              controllerEdit: _editarnombreController,
              labelText: 'Ingrese nuevo nombre del periodo'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Actualizar'),
              onPressed: () {
                update();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(int id, String currentName) {
    _editarnombreController.text = currentName;
    _editingId = id;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Periodo'),
          // content: CustomTextField(
          //     controllerEdit: _editarnombreController,
          //     labelText: 'Ingrese nuevo nombre del periodo'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                update();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista')),
      drawer: const Drawer(
        child: DrawerListView(),
      ),
      body: Column(
        children: [
          Center(child: Text('Página de Listas')),
          Container(
              height: 400,
              child: FutureBuilder(
                  future: futurePeriodos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No periods found'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final periodo = snapshot.data![index];

                          // return Row(
                          //   children: [
                          //     ListTile(
                          //       title: Text('${periodo.descripcion}'),
                          //       trailing: IconButton(
                          //         icon: Icon(Icons.edit),
                          //         onPressed: () {
                          //           _showEditDialog(
                          //               periodo.id, periodo.descripcion);
                          //         },
                          //       ),
                          //     ),
                          //     ListTile(
                          //       title: Text('${periodo.descripcion}'),
                          //       trailing: IconButton(
                          //         icon: Icon(Icons.edit),
                          //         onPressed: () {
                          //           _showDeleteDialog(
                          //               periodo.id, periodo.descripcion);
                          //         },
                          //       ),
                          //     )
                          //   ],
                          // );

                          return ListTile(
                              title: Text('${periodo.descripcion}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _showEditDialog(
                                          periodo.id, periodo.descripcion);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete_forever),
                                    onPressed: () {
                                      _showDeleteDialog(
                                          periodo.id, periodo.descripcion);
                                    },
                                  ),
                                ],
                              ));
                        },
                      );
                    }
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showInputDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
