import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final Function() onClicked;

  const ButtonWidget({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: Colors.grey.shade400,
            ),
          )),
      onPressed: onClicked,
      child: Text(text),
    );
  }
}
