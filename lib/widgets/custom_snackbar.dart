import 'package:flutter/material.dart';

void showNormalSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.green),
      ),
    ),
  );
}

void showErrorSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}
