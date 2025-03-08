import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText, // Set the hint text
        hintStyle: TextStyle(
          color: Colors.grey, // Customize hint text color if necessary
        ),
        border: OutlineInputBorder(), // Add a visible border
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, // Highlighted border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Default border color
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Adjust padding inside the text field
      ),
    );
  }
}
