import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String label;
  final Function() onPressedFunc;
  final Icon buttonIcon;

  const CustomIconButton({
    required this.label,
    required this.onPressedFunc,
    required this.buttonIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {
          onPressedFunc();
        },
        icon: buttonIcon,
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
