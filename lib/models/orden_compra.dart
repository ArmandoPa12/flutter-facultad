class OrdenCompra {
  // final String token;
  final int id;
  final String userGen;
  final String userTr;
  final String proveedorName;
  final String proveedorEmpresa;
  final String estadoProd;
  final String fecha;

  OrdenCompra(
      {required this.userGen,
      required this.proveedorEmpresa,
      required this.proveedorName,
      required this.id,
      required this.userTr,
      required this.estadoProd,
      required this.fecha});

  factory OrdenCompra.fromJson(Map<String, dynamic> json) {
    OrdenCompra nuevo = OrdenCompra(
      id: json['id'],
      userGen: json['usuario_generado'] != null
          ? json['usuario_generado']['username']
          : 'no asignado',
      userTr: json['usuario_gestor'] != null
          ? json['usuario_gestor']['username']
          : 'no asignado',
      estadoProd: json['estado_compra']['descripcion'],
      fecha: json['fecha_hora'],
      proveedorName: json['proveedor']['nombre'],
      proveedorEmpresa: json['proveedor']['empresa'],
    );

    print(nuevo);
    return nuevo;
  }
}
