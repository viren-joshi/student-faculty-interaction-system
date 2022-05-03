import 'package:flutter/material.dart';

import 'package:somaiya_project/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String?) onChangedCallback;
  final TextInputType textInputType;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.onChangedCallback, this.textInputType = TextInputType.text, this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: kGray,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black45,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChangedCallback,
    );
  }
}