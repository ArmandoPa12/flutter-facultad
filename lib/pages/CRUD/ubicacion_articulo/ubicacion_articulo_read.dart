import 'package:facultad/models/ubicacion_articulo.dart';
import 'package:flutter/material.dart';

class UbicacionArticuloRead extends StatefulWidget {
  final UbicacionArticulo articulo;
  // final bool nuevo;
  const UbicacionArticuloRead({super.key, required this.articulo});

  @override
  State<UbicacionArticuloRead> createState() => _UbicacionArticuloReadState();
}

class _UbicacionArticuloReadState extends State<UbicacionArticuloRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articulo.nombre),
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
                      "Ubicacion",
                      style: TextStyle(fontSize: 20),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fila ${widget.articulo.fila}'),
                    const Icon(Icons.archive_outlined)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estante ${widget.articulo.estanteId}'),
                    const Icon(Icons.toc_rounded)
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
                    Text(widget.articulo.descripcion),
                    // Icon(Icons.archive_outlined)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Creacion ${widget.articulo.fechaCreacion}'),
                    const Icon(Icons.av_timer_outlined)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vencimiento ${widget.articulo.fechaVencimiento}'),
                    const Icon(Icons.av_timer_outlined)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.articulo.tipoNombre),
                    const Icon(Icons.tag)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lista de materiales",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
              child: widget.articulo.materiales.isNotEmpty
                  ? ListView.builder(
                      itemCount: widget.articulo.materiales.length,
                      itemBuilder: (context, index) {
                        final material = widget.articulo.materiales[index];
                        return ListTile(
                          title: Text(material.nombre),
                          subtitle:
                              Text('${material.cantidad} unidades requeridas'),
                        );
                      },
                    )
                  : const Text('No requiere materiales')),
        ],
      ),
    );
  }
}
