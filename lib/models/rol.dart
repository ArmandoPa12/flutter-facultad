import 'package:facultad/models/permisos.dart';

class Rol {
  final int id;
  final String nombre;
  final String funcion;
  final String responsabilidad;
  final List<PermisosMrp> permisos;

  Rol(
      {required this.id,
      required this.nombre,
      required this.funcion,
      required this.responsabilidad,
      required this.permisos});

  @override
  String toString() {
    return '$id  - $nombre- $funcion- $responsabilidad- $permisos';
  }

  factory Rol.fromJson(Map<String, dynamic> json) {
    var permisosJson = json['permisos'] as List;
    List<PermisosMrp> permisosList = permisosJson
        .map((permisoJson) => PermisosMrp.fromJson(permisoJson))
        .toList();
    return Rol(
      id: json['id'],
      nombre: json['nombre'],
      funcion: json['funcion'],
      responsabilidad: json['responsabilidad'],
      permisos: permisosList,
    );
  }
}
