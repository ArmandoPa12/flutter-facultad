import 'dart:convert';

import 'package:facultad/models/periodo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PeriodoService {
  final apiUrl = '${dotenv.env['API_URL']}/tipo-articulo';

  Future<Permisos?> postPeriodo(String nombre) async {
    print('servicio ' + nombre);
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'nombre': nombre}));
    if (response.statusCode == 200) {
      dynamic nuevo = jsonDecode(response.body);
      if (nuevo['success']) {
        Permisos nuevop = Permisos.fromJson(nuevo['data']);
        return nuevop;
      }

      final body = jsonDecode(response.body);
      return Permisos.fromJson(body);
    }
    return null;
  }

  Future<List<Permisos>> fecthPeriodo2() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        List<dynamic> data = jsonResponse['data'];
        List<Permisos> periodos =
            data.map((item) => Permisos.fromJson(item)).toList();
        return periodos;
      } else {
        print('error periodod get ');
        return throw Exception('failed');
      }
      // List<dynamic> r = jsonDecode(response.body);
      // List<Periodo> t =
      //     r.map((dynamic item) => Periodo.fromJson(item)).toList();

      // print(r);
      // return t;
    } else {
      return throw Exception('failed');
    }
  }

  Future<Permisos?> put(int id, String nombre) async {
    final response = await http.put(Uri.parse('${apiUrl}/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'nombre': nombre}));
    // ----------
    if (response.statusCode == 200) {
      dynamic nuevo = jsonDecode(response.body);
      if (nuevo['success']) {
        print('servicio success put');
        Permisos nuevop = Permisos.fromJson(nuevo['data']);
        return nuevop;
      }

      final body = jsonDecode(response.body);
      return Permisos.fromJson(body);
    }
    return null;
  }

  Future<dynamic> delete(int id, String nombre) async {
    final response = await http.put(Uri.parse('${apiUrl}/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'nombre': nombre}));
    // ----------
    if (response.statusCode == 200) {
      dynamic nuevo = jsonDecode(response.body);
      if (nuevo['success']) {
        print('servicio success put');
        // Periodo nuevop = Periodo.fromJson(nuevo['data']);
        return 'eliminado';
      }

      // final body = jsonDecode(response.body);
      // return Periodo.fromJson(body);
    }
    return null;
  }
}
