// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
    this.textStyle,
    this.buttonColor = const Color(0xFF598393),
    this.textColor = Colors.black,
    this.buttonWidth = 0.85,
    this.buttonHeight = 0.07,
    this.textAlign = Alignment.center,
    this.fontSize = 16,
    this.borderSideColor = const Color(0xFF598393),
  });

  void Function()? onPressed;
  String? buttonName;
  TextStyle? textStyle;
  Color? buttonColor;
  Color? borderSideColor;
  Color? textColor;
  num buttonWidth;
  num buttonHeight;
  Alignment textAlign;
  double fontSize;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.buttonHeight,
      width: MediaQuery.of(context).size.width * widget.buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isButtonPressed = !_isButtonPressed;
          });
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: widget.borderSideColor!,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            widget.buttonColor,
          ),
        ),
        child: Align(
          alignment: widget.textAlign,
          child: Text(
            widget.buttonName ?? "",
            style: widget.textStyle ??
                TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
          ),
        ),
      ),
    );
  }
}
