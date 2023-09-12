import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
      child: Text(text),
      color: Colors.blue[300],
      textColor: Colors.white,
      // minWidth: 150.0,
      // height: 45.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      );
  }
}
