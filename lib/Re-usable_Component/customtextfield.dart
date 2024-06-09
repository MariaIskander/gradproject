// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.textStyle = const TextStyle(color: Colors.black),
    this.hintStyle = const TextStyle(
      color: Color(0xFF598393),
    ),
    this.cursorColor = const Color.fromRGBO(18, 69, 89, 1),
    this.cursorHeight = 17,
    this.autoCorrect = false,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
  });

  TextStyle? textStyle;
  TextStyle? hintStyle;
  Color? cursorColor;
  double? cursorHeight;
  bool? autoCorrect;
  Iterable<String>? autofillHints;
  TextEditingController? controller;
  Widget? suffixIcon;
  bool? obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  final String labelText;
  final String hintText;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: widget.autoCorrect!,
      onSaved: widget.onSaved,
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
      cursorHeight: widget.cursorHeight,
      obscureText: widget.obscureText!,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
              width: 1.2,
              color: Color.fromRGBO(18, 69, 89, 1),
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(18.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(18.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(18, 69, 89, 1),
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.2,
          ),
        ),
        suffixIcon: widget.suffixIcon,
        labelStyle: const TextStyle(color: Colors.black),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
      ),
      validator: widget.validator,
    );
  }
}
