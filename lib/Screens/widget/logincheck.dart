import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidzo_app/Screens/home/navbar.dart';

import 'package:kidzo_app/Screens/login/imports.dart';

class LoginCheck extends StatefulWidget {
  const LoginCheck({super.key});

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {

  dynamic checkIfParent;

  Future<bool> checkUserType(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userType = userDoc.data();
    checkIfParent = userType;
    return userType?.containsKey('code') == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: checkUserType(snapshot.data!.uid),
              builder: (context, userTypeSnapshot) {
                if (userTypeSnapshot.hasData) {
                  return NavBarPage(
                    isParent: checkIfParent?.containsKey('code') == true,
                  );
                } else {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color(0xFF598393),
                      size: 50,
                    ),
                  );
                }
              },
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}