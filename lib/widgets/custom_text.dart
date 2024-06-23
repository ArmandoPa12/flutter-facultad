import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String labelText;

  const CustomText({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(overflow: TextOverflow.ellipsis, labelText);
  }
}
