// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';
import 'package:kidzo_app/Re-usable_Component/customtextfield.dart';

class SignupTextField extends StatefulWidget {
  SignupTextField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formkey,
    required this.fullNameController,
    required this.isParent,
    this.parentCodeController,
  });

  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController confirmPasswordController;
  final TextEditingController passwordController;
  TextEditingController? parentCodeController;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isParent;

  @override
  State<SignupTextField> createState() => _SignupTextFieldState();
}

bool hidePass = true;
bool confirmHidePass = true;

class _SignupTextFieldState extends State<SignupTextField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isParent == false)
            Column(
              children: [
                CustomTextField(
                  controller: widget.parentCodeController,
                  suffixIcon: const Icon(
                    Icons.important_devices,
                    color: Color(0xFF598393),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ('Parent Code filed can\u0027t be empty');
                    } else if (!regex.hasMatch(value)) {
                      return ('Parent code length is ${value.length} (min. 6 Characters)');
                    }
                    return null;
                  },
                  labelText: "Parent Code",
                  hintText: "Parent Code",
                  onSaved: (value) {
                    widget.parentCodeController!.text = value!;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
              ],
            )
          else
            const SizedBox(
              height: 0,
              width: 0,
            ),
          CustomTextField(
            controller: widget.fullNameController,
            suffixIcon: const Icon(
              Icons.person,
              color: Color(0xFF598393),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              RegExp regex = RegExp(r'^.{3,}$');
              if (value!.isEmpty) {
                return ('Full Name filed can\u0027t be empty');
              } else if (!regex.hasMatch(value)) {
                return ('Please enter Your Full Name (min. 3 Characters)');
              }
              return null;
            },
            labelText: "Full Name",
            hintText: "Full Name",
            onSaved: (value) {
              widget.fullNameController.text = value!;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
          CustomTextField(
            onSaved: (value) {
              widget.emailController.text = value!;
            },
            hintStyle: const TextStyle(color: Color(0xFF598393)),
            textStyle: null,
            cursorColor:  appColor,
            controller: widget.emailController,
            suffixIcon: const Icon(
              Icons.email,
              color: Color(0xFF598393),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return ('Please enter your email');
              } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ('Please enter a valid email');
              }
              return null;
            },
            labelText: "Email",
            hintText: "example@example.com",
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
          CustomTextField(
            controller: widget.passwordController,
            suffixIcon: IconButton(
              color: const Color(0xFF598393),
              icon: Icon(
                hidePass
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  hidePass = !hidePass;
                });
              },
            ),
            obscureText: hidePass,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            validator: (value) {
              RegExp regex = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ('Password filed can\u0027t be empty');
              } else if (!regex.hasMatch(value)) {
                return ('Please enter a valid password (min. 6 Characters)');
              }
              return null;
            },
            labelText: "Paswword",
            hintText: "* * * * * * ",
            onSaved: (value) {
              widget.passwordController.text = value!;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
          CustomTextField(
            controller: widget.confirmPasswordController,
            suffixIcon: IconButton(
              color: const Color(0xFF598393),
              icon: Icon(
                confirmHidePass
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  confirmHidePass = !confirmHidePass;
                });
              },
            ),
            obscureText: confirmHidePass,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: (value) {
              RegExp regex = RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ('Password filed can\u0027t be empty');
              } else if (!regex.hasMatch(value)) {
                return ('Please enter a valid password (min. 6 Characters)');
              } else if (widget.confirmPasswordController.text !=
                  widget.passwordController.text) {
                return "Password don\u0027t match";
              }
              return null;
            },
            labelText: "Confirm Paswword",
            hintText: "* * * * * * ",
            onSaved: (value) {
              widget.confirmPasswordController.text = value!;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.020,
          ),
        ],
      ),
    );
  }
}
