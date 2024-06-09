import 'package:kidzo_app/Screens/home/navbar.dart';
import 'package:kidzo_app/Screens/login/imports.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const NavBarPage(),
                )),
                Fluttertoast.showToast(msg: 'Logged In Successfully'),
                setState(() {
                  isLoading = false;
                }),
              });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            headerName: "Login",
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
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
                      emailController: emailController,
                      passwordController: passwordController,
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
                              isParentLoginScreen: true,
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
                      isParent: true,
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
