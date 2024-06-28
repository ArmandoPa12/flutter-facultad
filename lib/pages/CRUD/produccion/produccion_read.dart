import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facultad/models/orden_compra.dart';
import 'package:facultad/models/orden_produccion.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  late String? localFilePath;
  bool pdfAvailable = false;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> requestStoragePermission() async {
  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     // Permiso concedido, procede con la lógica de descarga o escritura
  //     downloadPdf(); // Por ejemplo, llama a la función que descarga el PDF
  //   } else {
  //     // Permiso denegado, muestra un mensaje al usuario
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Permiso de almacenamiento denegado')),
  //     );
  //   }
  // }

  Future<void> downloadPdfProd() async {
    try {
      String? pdfUrl = widget.produccion.pdfData;
      String fileName = widget.produccion.fileName ?? 'unknown.pdf';

      if (pdfUrl != null) {
        print(pdfUrl);
        Dio dio = Dio();
        Directory? downloadsDir = await getExternalStorageDirectory();
        String downloadsPath =
            downloadsDir!.path.split('Android')[0] + 'Download/$fileName';

        await dio.download(pdfUrl, downloadsPath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF descargado en $downloadsPath')),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('PDF no disponible')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar el PDF')),
      );
    }
  }

  Future<void> downloadPdfComp() async {
    try {
      String? pdfUrl = widget.compra.pdfData;
      String fileName = widget.compra.fileName ?? 'unknown.pdf';

      if (pdfUrl != null) {
        print(pdfUrl);
        Dio dio = Dio();
        Directory? downloadsDir = await getExternalStorageDirectory();
        String downloadsPath =
            downloadsDir!.path.split('Android')[0] + 'Download/$fileName';

        await dio.download(pdfUrl, downloadsPath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF descargado en $downloadsPath')),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('PDF no disponible')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar el PDF')),
      );
    }
  }

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
                const SizedBox(height: 20),
                !widget.esCompra
                    ? Text('Proveedor: ${widget.compra.proveedorName}')
                    : const SizedBox.shrink(),
                ElevatedButton(
                  onPressed:
                      widget.esCompra ? downloadPdfProd : downloadPdfComp,
                  child: const Text('Descargar PDF'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
