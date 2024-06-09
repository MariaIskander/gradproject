import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/customprint.dart';
import 'package:kidzo_app/Screens/packages/background_Services.dart';
import 'package:kidzo_app/Screens/widget/logincheck.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';

import 'Screens/packages/overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();

// hi
  
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: OverlayWidget()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        printFunction('====================User is currently signed Out!');
      } else {
        printFunction('====================User is signed in');
      }
    });
    super.initState();
  }

//JJI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kidzo',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        home: const LoginCheck());
  }
}
