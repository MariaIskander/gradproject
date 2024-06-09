import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidzo_app/Screens/Child/child.dart';
import 'package:kidzo_app/Screens/Child/childHP.dart';
import 'package:kidzo_app/Screens/login/imports.dart';
import 'package:kidzo_app/Screens/packages/appInformation.dart';
import 'package:kidzo_app/Screens/signup/widgets/already_have_account.dart';
import 'package:kidzo_app/Screens/signup/widgets/signup_text_field.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';

class ChildSignUpScreen extends StatefulWidget {
  const ChildSignUpScreen({super.key});

  @override
  State<ChildSignUpScreen> createState() => _ChildSignUpScreenState();
}

class _ChildSignUpScreenState extends State<ChildSignUpScreen> {
  final TextEditingController childUsernameController = TextEditingController();
  final TextEditingController childEmailController = TextEditingController();
  final TextEditingController childPasswordController = TextEditingController();
  final TextEditingController childConfirmPasswordController =
      TextEditingController();
  final TextEditingController parentCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? docId;
  bool isLoading = false;
  List<Appinformation>? appinformation;

  Future signUp() async {
    try {
      String parentId = await checkParentCode(parentCodeController.text);
      final token = await FirebaseInstallations.instance.getToken();

      if (parentId.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: childEmailController.text,
                password: childPasswordController.text);
        Children children = Children(
            childUsernameController.text,
            childEmailController.text,
            [],
            parentCodeController.text,
            '',
            '',
            credential.user!.uid,
            parentId,
            childPasswordController.text,
            false,
            token,
            []);
        await FirebaseFirestore.instance
            .collection('children')
            .doc(credential.user?.uid)
            .set(children.toJSON())
            .then((value) {
          Fluttertoast.showToast(msg: 'Created successfully');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const ChildHomePage()));
        });
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: 'Cant create account because ${e.message.toString()}');
    }
  }

  Future<String> checkParentCode(String parentCode) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('code', isEqualTo: parentCode)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        // print('The parent id is ${parentid}');
      }
      return value.docs[0]['id'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(18, 69, 89, 1),
        foregroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const WelcomeScreen(),
                ),
              );
            }),
      ),
      body: Stack(
        children: [
          CustomHeader(
            headerName: "Create Your Account",
            paddingAllSizeHeight: 0.038,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.18,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: MediaQuery.of(context).size.height * 0.06,
                  ),
                  child: Column(
                    children: [
                      SignupTextField(
                        fullNameController: childUsernameController,
                        parentCodeController: parentCodeController,
                        isParent: false,
                        formkey: _formKey,
                        emailController: childEmailController,
                        passwordController: childPasswordController,
                        confirmPasswordController:
                            childConfirmPasswordController,
                      ),
                      if (isLoading == false)
                        CustomButton(
                          buttonColor: const Color(0xFF598393),
                          fontSize: 18,
                          textColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signUp().then((value) =>
                                  FlutterBackgroundService()
                                      .invoke('setAsBackground'));
                            } else {
                              return;
                            }
                          },
                          buttonName: "Sign Up",
                        )
                      else
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: const Color(0xFF598393),
                          size: 50,
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      AlreadyHaveAccount(
                        isParent: false,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
