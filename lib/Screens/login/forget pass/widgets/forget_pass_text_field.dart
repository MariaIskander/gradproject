// ignore_for_file: must_be_immutable

import 'package:kidzo_app/Screens/login/imports.dart';

class FotgetPassTextField extends StatefulWidget {
  FotgetPassTextField({
    super.key,
    required this.isLoading,
    required this.onPress,
    required this.emailController,
    required this.formkey,
  });

  final TextEditingController emailController;
  void Function()? onPress;
  bool isLoading;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  State<FotgetPassTextField> createState() => _FotgetPassTextFieldState();
}

class _FotgetPassTextFieldState extends State<FotgetPassTextField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white,
          ),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.024,
              right: MediaQuery.of(context).size.height * 0.024,
              top: MediaQuery.of(context).size.height * 0.08,
            ),
            child: Column(
              children: [
                CustomTextButton(
                  onTap: null,
                  textName:
                      "Enter your email and we will send you a password reset link",
                  textColor: Colors.black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                CustomTextField(
                  hintText: "example@example.com",
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Enter your Email you want to recover",
                  suffixIcon: const Icon(
                    Icons.email,
                    color: Color(0xFF598393),
                  ),
                  textInputAction: TextInputAction.done,
                  controller: widget.emailController,
                  hintStyle: const TextStyle(color: Color(0xFF598393)),
                  cursorColor: const Color.fromRGBO(18, 69, 89, 1),
                  onSaved: (value) {
                    widget.emailController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ('Please enter your email');
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ('Please enter a valid email');
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                if (widget.isLoading == false)
                  CustomButton(
                    textColor: Colors.white,
                    onPressed: widget.onPress,
                    buttonName: "Reset password",
                  )
                else
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: const Color(0xFF598393),
                    size: 50,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
