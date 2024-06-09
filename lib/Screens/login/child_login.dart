import 'package:kidzo_app/Screens/home/navbar.dart';
import 'package:kidzo_app/Screens/login/imports.dart';

class ChildLoginScreen extends StatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  State<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends State<ChildLoginScreen> {
  final TextEditingController childEmailController = TextEditingController();
  final TextEditingController childPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  Future login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: childEmailController.text,
              password: childPasswordController.text)
          .then((value) => {
                setState(() {
                  isLoading = false;
                }),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const NavBarPage(isParent: false))),
                Fluttertoast.showToast(msg: 'Logged In Successfully')
              });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  @override
  void dispose() {
    childEmailController.dispose();
    childPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
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
            paddingAllSizeHeight: 0.040,
            headerName: "Child Login",
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.22,
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
                  top: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Column(
                  children: [
                    LoginTextField(
                      formkey: _formkey,
                      emailController: childEmailController,
                      passwordController: childPasswordController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    CustomTextButton(
                      alignment: Alignment.centerRight,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ForgetPassword(
                              isParentLoginScreen: false,
                            ),
                          ),
                        );
                      },
                      textName: "Forget Password?",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.053,
                    ),
                    if (isLoading == false)
                      CustomButton(
                        buttonColor: const Color(0xFF598393),
                        fontSize: 18,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            login();
                          } else {
                            return;
                          }
                        },
                        buttonName: "login",
                      )
                    else
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0xFF598393),
                        size: 50,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    DontHaveAnAccount(
                      isParent: false,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
