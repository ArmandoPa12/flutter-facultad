class PermisosMrp {
  final int id;
  final String nombre;

  PermisosMrp({required this.id, required this.nombre});

  @override
  String toString() {
    return '$id - $nombre';
  }

  factory PermisosMrp.fromJson(Map<String, dynamic> json) {
    return PermisosMrp(id: json['id'], nombre: json['nombre']);
  }
}
