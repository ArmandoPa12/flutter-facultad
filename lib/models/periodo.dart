class Permisos {
  final int id;
  final String descripcion;

  Permisos({required this.id, required this.descripcion});

  @override
  String toString() {
    return '$id - $descripcion';
  }

  factory Permisos.fromJson(Map<String, dynamic> json) {
    return Permisos(id: json['id'], descripcion: json['nombre']);
  }
}
