import 'package:facultad/models/permisos.dart';
import 'package:facultad/models/rol.dart';
import 'package:facultad/service/permisos_service.dart';
import 'package:facultad/service/rol_service.dart';
import 'package:facultad/widgets/custom_text.dart';
import 'package:facultad/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RolRead extends StatefulWidget {
  final Rol rol;
  final bool nuevo;

  const RolRead({super.key, required this.rol, required this.nuevo});

  @override
  State<RolRead> createState() => _RolReadState();
}

class _RolReadState extends State<RolRead> {
  final TextEditingController _nombreCon = TextEditingController();
  final TextEditingController _funcion = TextEditingController();
  final TextEditingController _responsabilidad = TextEditingController();
  // lista de chips
  final ScrollController _scrollController = ScrollController();

  final _rolService = RolService();
  final _permisosService = PermisosService();

  late Future<List<PermisosMrp>> listaPermisos;

  final List<int> _permisosNuevos = [];
  final List<PermisosMrp> _permisosNuevosRol = [];

  List<PermisosMrp> _permisos = List.empty();
  // int? _editingId;

  @override
  void initState() {
    super.initState();
    listaPermisos = _permisosService.get();
  }

  void _agregarPermiso(PermisosMrp permiso) {
    if (!_permisosNuevosRol.any((p) => p.id == permiso.id)) {
      _permisosNuevos.add(permiso.id);
      _permisosNuevosRol.add(permiso);
      _scrollToEnd();
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // guardar
  void _guardar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Guardar Rol'),
          // content: Text('Seguro que quieres eliminar ${rol.nombre}'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Gaurdar'),
              onPressed: () async {
                if (_nombreCon.text == '' ||
                    _funcion.text == '' ||
                    _permisosNuevos.isEmpty) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Datos vacios')),
                  );
                } else {
                  try {
                    // Muestra un indicador de progreso
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    final result = await _rolService.postPeriodo(
                        _nombreCon.text, _funcion.text, _permisosNuevos);

                    // Cierra el indicador de progreso
                    Navigator.of(context).pop();

                    if (result == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Rol creado con éxito')),
                      );
                      Navigator.pushNamed(context, '/rol');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No se pudo crear el rol')),
                      );
                    }
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }

                // _rolService.delete(rol.id, rol.nombre);
                // Navigator.pushNamed(context, '/rol');
              },
            ),
          ],
        );
      },
    );
  }

  // eliminar
  void _showDeleteDialog(int id, String currentName) {
    _nombreCon.text = currentName;
    // _editingId = id;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Rol'),
          content: Text('Seguro que quieres eliminar ${widget.rol.nombre}'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                try {
                  // Muestra un indicador de progreso
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                  // Espera la respuesta del servicio
                  // final result = await _rolService.delete(
                  //     widget.rol.id, widget.rol.nombre);

                  // Cierra el indicador de progreso
                  Navigator.of(context).pop();

                  // if (result == true) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Rol eliminado con éxito')),
                  //   );
                  //   Navigator.pushNamed(context, '/rol');
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('No se pudo eliminar el rol')),
                  //   );
                  // }
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
                // _rolService.delete(rol.id, rol.nombre);
                Navigator.pushNamed(context, '/rol');
              },
            ),
          ],
        );
      },
    );
  }

  void _removePermiso(PermisosMrp p) {
    setState(() {
      _permisosNuevos.remove(p.id);
      _permisosNuevosRol.remove(p);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.nuevo) {
      _nombreCon.text = widget.rol.nombre;
      _funcion.text = widget.rol.funcion;
      _responsabilidad.text = widget.rol.responsabilidad;
      print(widget.rol.toString());
      _permisos = widget.rol.permisos;
    } else {}

    return Scaffold(
      appBar: AppBar(
        title: CustomText(labelText: widget.rol.nombre),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              // print(_permisosNuevos);
              // print(_nombreCon.text);
              // print(_funcion.text);

              _guardar();
            },
          ),
        ],
        // actions: !widget.nuevo
        //     ? [
        //         IconButton(
        //           icon: Icon(Icons.edit),
        //           onPressed: () {
        //             // Acción para editar
        //             print('Editar presionado');
        //           },
        //         ),
        //         IconButton(
        //           icon: Icon(Icons.delete),
        //           onPressed: () {
        //             _showDeleteDialog(widget.rol.id, widget.rol.nombre);
        //           },
        //         ),
        //       ]
        //     : [
        //         IconButton(
        //           icon: Icon(Icons.add_box_outlined),
        //           onPressed: () {
        //             // print(_permisosNuevos);
        //             // print(_nombreCon.text);
        //             // print(_funcion.text);

        //             _guardar();
        //           },
        //         ),
        //       ],
      ),
      body: Center(
        child: Column(
          children: [
            CustomTextField(
              controllerEdit: _nombreCon,
              labelText: 'Nombre',
              read: !widget.nuevo,
            ),
            CustomTextField(
              controllerEdit: _funcion,
              labelText: 'Funcionalidad',
              read: !widget.nuevo,
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Funcionalidad',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _funcion.text,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _permisos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${_permisos[index].toString()}'),
                    onTap: () {},
                  );
                },
              ),
            ),
            widget.nuevo
                ? Container(
                    height: 50, // Ajusta esta altura según tus necesidades
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: _permisosNuevosRol.length,
                      itemBuilder: (context, index) {
                        final permiso = _permisosNuevosRol[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(permiso.nombre),
                            onDeleted: () => _removePermiso(permiso),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            widget.nuevo
                ? Container(
                    height: 400,
                    child: FutureBuilder(
                        future: listaPermisos,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No periods found'));
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final periodo = snapshot.data![index];
                                  return ListTile(
                                    title: Text(periodo.nombre),
                                    onTap: () {
                                      setState(() {
                                        // _permisosNuevos.add(periodo.id);
                                        _agregarPermiso(periodo);
                                      });
                                      print(_permisosNuevos);
                                    },
                                  );
                                  // return Text('${periodo.nombre}');
                                });
                          }
                        }),
                  )
                : const SizedBox.shrink()
          ],
        ),
        // child: Text('Detalles del Rol: ${rol}'),
      ),
    );
  }
}
