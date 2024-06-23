import 'package:facultad/models/material.dart';

class UbicacionArticulo {
  final int id;
  final int estanteId;
  final int fila;
  final int cantArticulo;
  final String nombre;
  final String descripcion;
  final String fechaCreacion;
  final String fechaVencimiento;
  final String tipoNombre;
  final List<Material> materiales;

  UbicacionArticulo(
      {required this.id,
      required this.estanteId,
      required this.fila,
      required this.cantArticulo,
      required this.nombre,
      required this.descripcion,
      required this.fechaCreacion,
      required this.fechaVencimiento,
      required this.tipoNombre,
      required this.materiales});

  @override
  String toString() {
    return '$id  - $nombre- $descripcion- $fechaCreacion- $cantArticulo -$materiales';
  }

  factory UbicacionArticulo.fromJson(Map<String, dynamic> json) {
    var materialJson = json['articulo']['materiales'] as List;
    List<Material> materialesList = materialJson
        .map((materialJson) => Material.fromJson(materialJson))
        .toList();

    return UbicacionArticulo(
      id: json['id'],
      estanteId: json['estante_id'],
      fila: json['fila'],
      cantArticulo: json['cant_articulo'],
      nombre: json['articulo']['nombre'],
      descripcion: json['articulo']['descripcion'],
      fechaCreacion: json['articulo']['fecha_creacion'],
      fechaVencimiento: json['articulo']['fecha_vencimiento'],
      tipoNombre: json['articulo']['tipo']['nombre'],
      materiales: materialesList,
    );
  }
}
