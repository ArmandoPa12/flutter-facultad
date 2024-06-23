import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controllerEdit;
  final String labelText;
  final bool oscureText;
  final bool read;
  final int? largo;

  const CustomTextField(
      {super.key,
      required this.controllerEdit,
      required this.labelText,
      this.oscureText = false,
      this.read = false,
      this.largo = null});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerEdit,
      decoration: InputDecoration(labelText: labelText),
      obscureText: oscureText,
      readOnly: read,
    );
  }
}
