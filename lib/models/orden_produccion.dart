class OrdenProduccion {
  // final String token;
  final int id;
  final String userGen;
  final String userTr;
  final String estadoProd;
  final String fecha;

  OrdenProduccion(
      {required this.userGen,
      required this.id,
      required this.userTr,
      required this.estadoProd,
      required this.fecha});

  factory OrdenProduccion.fromJson(Map<String, dynamic> json) {
    return OrdenProduccion(
      id: json['id'],
      userGen: json['usuario_generado'] != null
          ? json['usuario_generado']['username']
          : 'no asignado',
      userTr: json['usuario_trabajador'] != null
          ? json['usuario_trabajador']['username']
          : 'no asignado',
      estadoProd: json['estado_produccion']['descripcion'],
      fecha: json['fechar_hora'],
    );
  }
}
