// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidzo_app/Screens/login/imports.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({
    super.key,
    required this.isParentLoginScreen,
  });

  final bool isParentLoginScreen;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool? isParentLoginScreen;
  bool isParent = false;

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      final usersRef = FirebaseFirestore.instance.collection('users');
      final childrenRef = FirebaseFirestore.instance.collection('children');
      bool emailExists = false;

      await usersRef
          .where('Email', isEqualTo: emailcontroller.text.trim().toLowerCase())
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          emailExists = true;
          isParent = true;
        }
      });

      if (!emailExists) {
        await childrenRef
            .where('Email',
                isEqualTo: emailcontroller.text.trim().toLowerCase())
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            emailExists = true;
          }
        });
      }

      if (emailExists) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailcontroller.text.trim())
            .then((_) => {
                  Fluttertoast.showToast(msg: "An email has been send"),
                  if (widget.isParentLoginScreen == isParent)
                    {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ParentLoginScreen(),
                        ),
                      ),
                    }
                  else
                    {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChildLoginScreen(),
                        ),
                      ),
                    },
                  setState(() {
                    isLoading = false;
                  }),
                });
      } else {
        Fluttertoast.showToast(msg: "Email does not exist");
        setState(() {
          isLoading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString(), fontSize: 14);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              if (widget.isParentLoginScreen == true) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const ParentLoginScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChildLoginScreen(),
                  ),
                );
              }
            }),
        backgroundColor: const Color.fromRGBO(18, 69, 89, 1),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          CustomHeader(
            headerName: 'Forget Password',
          ),
          FotgetPassTextField(
            emailController: emailcontroller,
            formkey: _formkey,
            isLoading: isLoading,
            onPress: () {
              if (_formkey.currentState!.validate()) {
                resetPassword();
              } else {
                return;
              }
            },
          ),
        ],
      ),
    );
  }
}
