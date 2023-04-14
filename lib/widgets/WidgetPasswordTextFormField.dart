import "package:flutter/material.dart";

class PasswordTextField extends StatelessWidget {
  final bool obserText;
  final Function validator;
  final String name;
  final Function onTap;

  const PasswordTextField(
      {required this.name,
      required this.obserText,
      required this.validator,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        validator;
      },
      obscureText: obserText,
      decoration: InputDecoration(
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: () {
            onTap;
          },
          child: Icon(
            obserText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
