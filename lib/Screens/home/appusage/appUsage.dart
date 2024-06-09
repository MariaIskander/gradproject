import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/constant.dart';
import 'package:kidzo_app/Screens/login/imports.dart';
import 'package:kidzo_app/Screens/packages/app_info_model.dart';
import 'package:intl/intl.dart';

class AppUsage extends StatefulWidget {
  AppUsage({super.key, this.appsInfo});
  List<AppInfoModel>? appsInfo;

  @override
  State<AppUsage> createState() => _AppUsageState();
}

class _AppUsageState extends State<AppUsage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF124559),
        appBar: AppBar(
            title: const SizedBox(), backgroundColor: const Color(0xFF124559)),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Text(
                    'App Usage',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 2.5,
                    indent: 40,
                    endIndent: 40,
                    color: kPrimaryLightColor,
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'App Usage allows you to monitor your child activity on each application',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              FutureBuilder(
                  future: DeviceApps.getInstalledApplications(
                      includeSystemApps: true,
                      onlyAppsWithLaunchIntent: true,
                      includeAppIcons: true),
                  builder: (context, Snapshot) {
                    if (!Snapshot.hasData) {
                      return Container(
                          decoration: const BoxDecoration(),
                          child: const Text(
                            'we dont have any installed apps',
                          ));
                    }

                    return Padding(
                        padding: const EdgeInsets.only(top: 0.5),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.appsInfo!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color.fromARGB(
                                                255, 215, 215, 215)),
                                        child: Center(
                                          child: ExpansionTile(
                                            title: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                widget.appsInfo![index]
                                                        .appName ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w400,
                                                    color: kPrimaryColor),
                                              ),
                                            ),
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  "Last Used Time :  ${DateFormat('dd/MM/yyyy  HH:mm:ssa').format(DateTime.fromMillisecondsSinceEpoch(int.parse("${widget.appsInfo?[index].lastUsedTime}")))}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  "Screen Time :  ${DateFormat('HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(int.parse("${widget.appsInfo?[index].screenTime}")))}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ));
                  }),
            ],
          ),
        ));
  }
}
