import 'package:facultad/models/orden_compra.dart';
import 'package:facultad/models/orden_produccion.dart';
import 'package:flutter/material.dart';

class EstadoProduccionRead extends StatefulWidget {
  final OrdenProduccion produccion;
  final OrdenCompra compra;
  final bool esCompra;

  // final bool nuevo;
  const EstadoProduccionRead(
      {super.key,
      required this.produccion,
      required this.compra,
      required this.esCompra});

  @override
  State<EstadoProduccionRead> createState() => _UbicacionArticuloReadState();
}

class _UbicacionArticuloReadState extends State<EstadoProduccionRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Usuario Generador",
                      style: TextStyle(fontSize: 20),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.esCompra
                        ? widget.produccion.userGen
                        : widget.compra.userGen),
                    const Icon(Icons.edit_note_rounded)
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.esCompra ? "Usuario Trabajador" : 'Usuario Gestor',
                      style: TextStyle(fontSize: 20),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.esCompra
                        ? widget.produccion.userTr
                        : widget.compra.userTr),
                    const Icon(Icons.remove_red_eye_outlined)
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Informacion",
                      style: TextStyle(fontSize: 20),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Fecha ${widget.esCompra ? widget.produccion.fecha : widget.compra.fecha}'),
                    // Icon(Icons.archive_outlined)
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estado '),
                    Text(
                      widget.esCompra
                          ? widget.produccion.estadoProd
                          : widget.compra.estadoProd,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                    // const Icon(Icons.av_timer_outlined)
                  ],
                ),
                !widget.esCompra
                    ? Text(widget.compra.proveedorName)
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
