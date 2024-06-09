// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  CustomTextButton({
    super.key,
    required this.onTap,
    this.onLongTap,
    required this.textName,
    this.textStyle,
    this.alignment = Alignment.center,
    this.textAlign = TextAlign.center,
    this.textColor = const Color(0xFF598393),
    this.textFontSize = 18,
    this.isBold = true,
  });

  void Function()? onTap;
  void Function()? onLongTap;
  String? textName;
  TextAlign? textAlign;
  TextStyle? textStyle;
  Color? textColor;
  double? textFontSize;
  AlignmentGeometry? alignment;
  bool? isBold;

  @override
  State<CustomTextButton> createState() => _CustomTextButton();
}

class _CustomTextButton extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongTap ?? () {},
      child: Align(
        alignment: widget.alignment!,
        child: Text(
          textAlign: widget.textAlign,
          widget.textName ?? "",
          style: widget.textStyle ??
              TextStyle(
                fontWeight:
                    widget.isBold! ? FontWeight.bold : FontWeight.normal,
                fontSize: widget.textFontSize,
                color: widget.textColor,
              ),
        ),
      ),
    );
  }
}

