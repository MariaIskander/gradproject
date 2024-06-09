import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';
import 'package:kidzo_app/Screens/home/navbar.dart';
import 'package:kidzo_app/Screens/packages/app_info_model.dart';

class AppLock extends StatefulWidget {
  AppLock({super.key, this.appsInfo, this.childId});
  List<AppInfoModel>? appsInfo;
  String? childId;
  @override
  State<AppLock> createState() => _AppLockState();
}

class _AppLockState extends State<AppLock> {
  bool _isAppLocked(int index) {
    return false;
  }
  
 

  bool isSelected = false;


  Future<void> updataAppLoced() async {
    List<Map<String, dynamic>> updatedList = widget.appsInfo!.map((item) {
      return item.toMap();
    }).toList();
    await FirebaseFirestore.instance
        .collection('children')
        .doc(widget.childId)
        .update({'appinfo': updatedList});
  }
  

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(18, 69, 89, 1),
          Color.fromRGBO(18, 69, 89, 1)
        ])),
      ),
      SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                alignment: Alignment.topLeft,
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NavBarPage()));
                    },
                    child: Image.asset(
                      "assets/images/left_arrow1.png",
                      fit: BoxFit.contain,
                    )),
              ),
            ),
          ],
        ),
      )),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 75),
        child: Text(
          'App lock',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Alice',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 130),
        child: Image.asset('assets/images/Line2.png'),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 146, horizontal: 20),
        child: Text(
          'App locking allows you to restrict access to specific apps on your child device',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Alice',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 200.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white,
          ),
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            itemCount: widget.appsInfo!.length,
            itemBuilder: (context, index) {
              return Visibility(
                visible: !_isAppLocked(index),
                child: GestureDetector(
                  onTap: () {},
                  child: ListTile(
                      title: Text(
                        widget.appsInfo![index].appName ?? '',
                        style: const TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      // leading: Image.memory((widget.appinfo![index]).icon),
                      trailing: Switch(
                        onChanged: (value) {
                          setState(() {
                            // isSelected = !isSelected;
                            widget.appsInfo![index].locked = value;

                            ///ToDo: Fun firebase send requst to make blocked the app.
                            ///
                            log('applicationAccess[index].isSelected is ${widget.appsInfo![index].locked}');
                            log('applicationAccess[index].isSelected is ${widget.appsInfo![index].appPackage}');
                          });
                          updataAppLoced();
                        },
                        value: widget.appsInfo![index].locked!,
                        inactiveTrackColor:
                            const Color.fromRGBO(255, 255, 255, 1),
                        activeColor: kPrimaryColor,
                      )),
                ),
              );
            },
          ),
        ),
      )
    ]));
  }
}

class ApplicationAccess {
  final Application app;
  bool isSelected;

  ApplicationAccess({required this.app, this.isSelected = false});
}
