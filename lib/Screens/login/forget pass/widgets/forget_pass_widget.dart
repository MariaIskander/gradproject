// ignore_for_file: must_be_immutable
import 'package:kidzo_app/Screens/login/imports.dart';

class ForgetPasswordWidget extends StatelessWidget {
  ForgetPasswordWidget({
    super.key,
    required this.emailController,
    required this.formkey,
  });

  final TextEditingController emailController;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          children: [
            CustomTextField(
              autoCorrect: false,
              cursorHeight: null,
              hintText: "example@example.com",
              keyboardType: TextInputType.emailAddress,
              labelText: "Enter your Email you want to recover",
              obscureText: false,
              suffixIcon: const Icon(
                Icons.email,
                color: Color(0xFF598393),
              ),
              textInputAction: TextInputAction.done,
              controller: emailController,
              hintStyle: const TextStyle(color: Color(0xFF598393)),
              textStyle: null,
              cursorColor: const Color.fromRGBO(18, 69, 89, 1),
              onSaved: (value) {
                emailController.text = value!;
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
          ],
        ));
  }
}
