import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidzo_app/Re-usable_Component/customprint.dart';
import 'package:usage_stats/usage_stats.dart';

class AppInfo extends StatefulWidget {
  final Application application;
  const AppInfo({super.key, required this.application});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  UsageInfo? appStats;
  getUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    // grant usage permission - opens Usage Settings

    // query events
    // List<EventUsageInfo> events =
    //     await UsageStats.queryEvents(startDate, endDate);

    // query usage stats
    List<UsageInfo> usageStats =
        await UsageStats.queryUsageStats(startDate, endDate);

    if (usageStats.isNotEmpty) {
      for (var element in usageStats) {
        if (element.packageName == widget.application.packageName) {
          setState(() {
            appStats = element;
          });
        }
      }
    }
    if (appStats != null) {
      printFunction('value of App Usage${appStats!.packageName}');
    } else {
      printFunction('APPSTATS IS NULL OR APP NOT OPPENED');
    }
  }

  @override
  void initState() {
    super.initState();
    getUsage();
  }

  @override
  Widget build(BuildContext context) {
    bool isNull = appStats != null;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.application.appName),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text(
                    'Screen Time :',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    isNull
                        ? '${(int.parse(appStats!.totalTimeInForeground!) / 1000 / 60).toStringAsFixed(2)} min:sec'
                        : 'APP NOT OPENED',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
                    'Last Time Used :',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    isNull
                        ? DateFormat('dd-MM-yyyy HH-mm-ss').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              int.parse(appStats!.lastTimeUsed!),
                            ),
                          )
                        : 'APP NOT OPENED',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
