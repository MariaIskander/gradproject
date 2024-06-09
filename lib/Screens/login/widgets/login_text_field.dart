// ignore_for_file: must_be_immutable
import 'package:kidzo_app/Screens/login/imports.dart';

class LoginTextField extends StatefulWidget {
  LoginTextField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formkey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

bool hidepass = true;

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomTextField(
          onSaved: (value) {
            widget.emailController.text = value!;
          },
          hintStyle: const TextStyle(color: Color(0xFF598393)),
          textStyle: null,
          cursorColor: appColor,
          cursorHeight: null,
          autoCorrect: false,
          controller: widget.emailController,
          suffixIcon: const Icon(
            Icons.email,
            color: Color(0xFF598393),
          ),
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
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
          labelText: "Email",
          hintText: "example@example.com",
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        CustomTextField(
          textStyle: null,
          hintStyle: const TextStyle(color: Color(0xFF598393)),
          cursorColor: appColor,
          cursorHeight: null,
          autoCorrect: false,
          controller: widget.passwordController,
          suffixIcon: IconButton(
            color: const Color(0xFF598393),
            icon: Icon(
              hidepass
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: () {
              setState(() {
                hidepass = !hidepass;
              });
            },
          ),
          obscureText: hidepass,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ('Password filed can\u0027t be empty');
            }
            if (!regex.hasMatch(value)) {
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
      ]),
    );
  }
}
