import 'dart:convert';

import 'package:facultad/models/ubicacion_articulo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UbicacionArticuloService {
  final apiUrl = '${dotenv.env['API_URL']}/ubicacion-articulo';

  Future<List<UbicacionArticulo>> get() async {
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
        List<UbicacionArticulo> articulos =
            data.map((item) => UbicacionArticulo.fromJson(item)).toList();
        return articulos;
      } else {
        return throw Exception('failed');
      }
    } else {
      return throw Exception('failed');
    }
  }
}
