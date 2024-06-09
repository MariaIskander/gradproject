import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:kidzo_app/Re-usable_Component/custombutton.dart';
import 'package:kidzo_app/Screens/login/child_login.dart';
import 'package:kidzo_app/Screens/login/parent_login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usage_stats/usage_stats.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> overlayPermissin() async {
    final grantee = await FlutterOverlayWindow.isPermissionGranted();
    if (grantee == false) {
      FlutterOverlayWindow.requestPermission();
    }
  }

  static Future<bool?> checkUsagePermission() async {
    bool isPermission = UsageStats.checkUsagePermission() as bool;
    return isPermission;
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    final Status = await permission.request();
    if (Status == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Access Garented')));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Access Denied')));
    }
  }

  @override
  void initState() {
    permissionCheck();
    super.initState();
  }

  permissionCheck() async {
    await Permission.ignoreBatteryOptimizations.request();
    await Permission.notification.request();
    await Permission.calendarFullAccess.request();
    await Permission.location.request();
    await overlayPermissin();
    await UsageStats.grantUsagePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.06,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.049,
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color(0xFF598393),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/kidzo_logo.png"),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  CustomButton(
                    fontSize: 18,
                    buttonColor: Colors.white,
                    textColor: const Color(0xFF598393),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ParentLoginScreen(),
                        ),
                      );
                    },
                    buttonName: 'Parent',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.032,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChildLoginScreen())).then((value) =>
                          FlutterBackgroundService().invoke('setAsForeground'));
                    },
                    buttonName: "Child",
                    fontSize: 18,
                    textColor: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
