import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String textBtn;
  final VoidCallback onPressed;
  final Color colorBtn;
  final Color textColorBtn;

  const RoundedButton({
    super.key,
    required this.textBtn,
    required this.onPressed,
    required this.colorBtn,
    required this.textColorBtn,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colorBtn,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          ),
          onPressed: onPressed,
          child: Text(
            textBtn,
            style: TextStyle(color: textColorBtn),
          ),
        ),
      ),
    );
  }
}
