import 'dart:convert';
import 'package:facultad/models/rol.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RolService {
  final apiUrl = '${dotenv.env['API_URL']}/rol';

  Future<List<Rol>> get() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        List<dynamic> data = jsonResponse['data'];
        List<Rol> roles = data.map((item) => Rol.fromJson(item)).toList();
        return roles;
      } else {
        return throw Exception('failed');
      }
    } else {
      return throw Exception('failed');
    }
  }

  Future<bool?> postPeriodo(
      String nombre, String funcion, List<int> permisos) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'funcion': funcion,
          'responsabilidad': 'responsabilidad',
          'permisos': permisos
        }));
    if (response.statusCode == 200) {
      dynamic nuevo = jsonDecode(response.body);
      if (nuevo['success']) {
        // Rol nuevop = Rol.fromJson(nuevo['data']);
        return true;
      }

      // final body = jsonDecode(response.body);
      return false;
    }
    return false;
  }

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

  Future<dynamic> delete(int id, String nombre) async {
    final response = await http.delete(Uri.parse('${apiUrl}/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'nombre': nombre}));
    // ----------
    if (response.statusCode == 200) {
      dynamic nuevo = jsonDecode(response.body);
      if (nuevo['success']) {
        print('servicio success delete');
        // Periodo nuevop = Periodo.fromJson(nuevo['data']);
        return 'eliminado';
      }

      // final body = jsonDecode(response.body);
      // return Periodo.fromJson(body);
    }
    return null;
  }
}
