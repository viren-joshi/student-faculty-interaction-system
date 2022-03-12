import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';

class SubmitButton extends StatelessWidget {
  final Function () onPressesCallback;
  const SubmitButton({
    Key? key,required this.onPressesCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      decoration: const BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: TextButton(
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        onPressed: onPressesCallback,
      ),
    );
  }
}