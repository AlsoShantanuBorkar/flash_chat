import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final Color buttonColor;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (() {
            onPressed();
          }),
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
