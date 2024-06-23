class Material {
  final int id;
  final String nombre;
  final int cantidad;

  Material({required this.id, required this.nombre, required this.cantidad});

  @override
  String toString() {
    return '$id  - $nombre- $cantidad ';
  }

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
        id: json['id'], nombre: json['nombre'], cantidad: json['cantidad']);
  }
}
