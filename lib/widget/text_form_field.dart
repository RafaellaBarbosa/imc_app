import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ATextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const ATextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    required this.hintText,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 70,
      width: 140,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
