import "package:flutter/material.dart";

class MyTextFormField extends StatelessWidget {
  final Function validator;
  final String name;

  const MyTextFormField(
      {required this.name, required this.validator, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        validator;
      },
      decoration: InputDecoration(
        hintText: name,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
