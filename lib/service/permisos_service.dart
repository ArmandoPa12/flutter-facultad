import 'dart:convert';

import 'package:facultad/models/permisos.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PermisosService {
  final apiUrl = '${dotenv.env['API_URL']}/permiso';

  Future<List<PermisosMrp>> get() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        List<dynamic> data = jsonResponse['data'];
        List<PermisosMrp> permisos =
            data.map((item) => PermisosMrp.fromJson(item)).toList();
        return permisos;
      } else {
        return throw Exception('failed');
      }
    } else {
      return throw Exception('failed');
    }
  }

  // Future<Periodo?> postPeriodo(String nombre) async {
  //   print('servicio ' + nombre);
  //   final response = await http.post(Uri.parse(apiUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{'nombre': nombre}));
  //   if (response.statusCode == 200) {
  //     dynamic nuevo = jsonDecode(response.body);
  //     if (nuevo['success']) {
  //       Periodo nuevop = Periodo.fromJson(nuevo['data']);
  //       return nuevop;
  //     }

  //     final body = jsonDecode(response.body);
  //     return Periodo.fromJson(body);
  //   }
  //   return null;
  // }

  // Future<Periodo?> put(int id, String nombre) async {
  //   final response = await http.put(Uri.parse('${apiUrl}/${id}'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{'nombre': nombre}));
  //   // ----------
  //   if (response.statusCode == 200) {
  //     dynamic nuevo = jsonDecode(response.body);
  //     if (nuevo['success']) {
  //       print('servicio success put');
  //       Periodo nuevop = Periodo.fromJson(nuevo['data']);
  //       return nuevop;
  //     }

  //     final body = jsonDecode(response.body);
  //     return Periodo.fromJson(body);
  //   }
  //   return null;
  // }

  // Future<dynamic> delete(int id, String nombre) async {
  //   final response = await http.put(Uri.parse('${apiUrl}/${id}'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{'nombre': nombre}));
  //   // ----------
  //   if (response.statusCode == 200) {
  //     dynamic nuevo = jsonDecode(response.body);
  //     if (nuevo['success']) {
  //       print('servicio success put');
  //       // Periodo nuevop = Periodo.fromJson(nuevo['data']);
  //       return 'eliminado';
  //     }

  //     // final body = jsonDecode(response.body);
  //     // return Periodo.fromJson(body);
  //   }
  //   return null;
  // }
}
