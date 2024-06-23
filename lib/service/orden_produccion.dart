import 'dart:convert';

import 'package:facultad/models/orden_produccion.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OrdenProduccionService {
  final apiUrl = '${dotenv.env['API_URL']}/orden-produccion';

  // Future<Usuario> get(int id) async {
  //   String nuevo = '$apiUrl/$id';
  //   final response = await http.get(Uri.parse(nuevo));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //     if (jsonResponse['success']) {
  //       List<dynamic> data = jsonResponse['data'];

  //       List<Usuario> articulos =
  //           data.map((item) => Usuario.fromJson(item)).toList();
  //       return articulos.first;
  //     } else {
  //       return throw Exception('failed');
  //     }
  //   } else {
  //     return throw Exception('failed');
  //   }
  // }

  Future<List<OrdenProduccion>> get() async {
    // String nuevo = '$apiUrl/$id';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        List<dynamic> data = jsonResponse['data'];
        print(data);
        // List<UbicacionArticulo> materials = data
        //     .where((item) => item['tipo_id'] == 1) // Filtra por tipo_id
        //     .map<Material>((item) => Material.fromJson(item))
        //     .toList();
        List<OrdenProduccion> lista =
            data.map((item) => OrdenProduccion.fromJson(item)).toList();
        return lista;
      } else {
        return throw Exception('failed');
      }
    } else {
      return throw Exception('failed');
    }
  }
}
