class Usuario {
  final int id;
  final String personaNombre;
  final String personaApellidoP;
  final String personaApellidoM;
  final String correo;
  final String celular;
  final String rolNombre;
  final String imagen;

  Usuario(
      {required this.id,
      required this.personaNombre,
      required this.personaApellidoP,
      required this.personaApellidoM,
      required this.correo,
      required this.celular,
      required this.imagen,
      required this.rolNombre});

  @override
  String toString() {
    return '$id  - $personaNombre- $personaApellidoP- $personaApellidoM- $correo';
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    // var permisosJson = json['permisos'] as List;
    // List<PermisosMrp> permisosList = permisosJson
    //     .map((permisoJson) => PermisosMrp.fromJson(permisoJson))
    //     .toList();
    return Usuario(
      id: json['id'],
      personaNombre: json['persona']['nombre'],
      personaApellidoP: json['persona']['apellido_p'],
      personaApellidoM: json['persona']['apellido_m'],
      correo: json['persona']['correo'],
      celular: json['persona']['celular'],
      rolNombre: json['rol']['nombre'],
      imagen: json['photo'],
    );
  }
}
