import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function(String text) onChangeFunc;
  final bool isPassword;

  const CustomTextField({
    required this.label,
    required this.onChangeFunc,
    required this.isPassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: isPassword,
        onChanged: (newText) {
          onChangeFunc(newText);
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
