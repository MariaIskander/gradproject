// ignore_for_file: must_be_immutable
import 'package:kidzo_app/Screens/signup/imports.dart';

class AlreadyHaveAccount extends StatelessWidget {
  AlreadyHaveAccount({
    super.key,
    required this.isParent,
  });

  bool isParent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextButton(
          onTap: null,
          textName: "Already Have An Account?",
          isBold: true,
          textColor: Colors.grey,
          textFontSize: 15,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        CustomTextButton(
          textFontSize: 21,
          onTap: () {
            if (isParent == true) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const ParentLoginScreen(),
                ),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const ChildLoginScreen(),
                ),
              );
            }
          },
          textName: "Login",
        ),
      ],
    );
  }
}
