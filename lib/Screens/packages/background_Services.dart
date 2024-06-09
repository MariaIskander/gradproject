import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:kidzo_app/Re-usable_Component/customprint.dart';
import 'package:kidzo_app/Screens/packages/alert_dialog_service.dart';
import 'package:kidzo_app/Screens/packages/app_info_model.dart';
import 'package:usage_stats/usage_stats.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC57p0R3tJqj-Df_sWKHGXXz4I_g0BllRY',
          appId: '1:897461993498:android:961ab21bbb9cf01bb011a3',
          messagingSenderId: '897461993498',
          projectId: 'kidzo-f479a'));
  getAppsLocked();
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      autoStartOnBoot: true,
    ),
  );
  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  service.on('stop').listen((event) {
    service.stopSelf();
  });

  // Initialize usage data
  Map<String, UsageInfo> previousUsage = {};
  String? currentlyOpenAppId;
  final monitoredApps = await getMonitoredApps();

  // Start the periodic check
  startPeriodicCheck(service, previousUsage, currentlyOpenAppId, monitoredApps);
}

void startPeriodicCheck(
    ServiceInstance service,
    Map<String, UsageInfo> previousUsage,
    String? currentlyOpenAppId,
    Map<String, AppInfoModel> monitoredApps) {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    final currentUsage = await getCurrentUsageStats(monitoredApps);
    

    final openedAppId =
        checkIfAnyAppHasBeenOpened(currentUsage, previousUsage, monitoredApps);
   
    
    if (openedAppId != null) {
      
      currentlyOpenAppId = openedAppId;
      AlertDialogService.createAlertDialog();
    } else if (currentlyOpenAppId != null && checkIfAppIsClosed(currentUsage, currentlyOpenAppId!)) {
     
      currentlyOpenAppId = null;
      AlertDialogService.closeAlertDialog();
    }

    // Update previous usage for the next check
    previousUsage = Map.from(currentUsage);

    if (service is AndroidServiceInstance &&
        await service.isForegroundService()) {
      service.setForegroundNotificationInfo(
        title: 'Kidzzo',
        content: 'Hello Kiddo',
      );
    }

    service.invoke('update');
  });
}

getUserId() {
  var user = FirebaseAuth.instance.currentUser;
  printFunction('Uid of the child is ${user!.uid}');
  return user.uid;
}

getAppsLocked() async {
  final docId = await getUserId();
  QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
      .collection('children')
      .where(
        'id',
        isEqualTo: docId,
      )
      .get();
  
}

Future<Map<String, AppInfoModel>> getMonitoredApps() async {
  //Firebase store get data
  //Get apps info for this child
  // if locked is true add on map
  Map<String, AppInfoModel> appsLocked = {};
  // [appsLocked] add on it all apps that locked

  // Replace with actual implementation to get the list of monitored apps
  /*
  {
    'com.google.android.youtube': AppInfoModel(
        appName: 'YouTube', appPackage: 'com.google.android.youtube'),
  }
   */
  return {
    'com.google.android.youtube': AppInfoModel(
        appName: 'YouTube', appPackage: 'com.google.android.youtube'),
    "com.google.android.googlequicksearchbox": AppInfoModel(
      appName: 'Google',
      appPackage: "com.google.android.googlequicksearchbox",
    )
  };
}

Future<Map<String, UsageInfo>> getCurrentUsageStats(
    Map<String, AppInfoModel> monitoredApps) async {
  final endDate = DateTime.now();
  final startDate = endDate.subtract(const Duration(minutes: 3));

  final usageStats =
      await UsageStats.queryAndAggregateUsageStats(startDate, endDate);
  usageStats
      .removeWhere((appId, usageInfo) => !monitoredApps.containsKey(appId));

  return usageStats;
}

bool checkIfAppIsClosed(Map<String, UsageInfo> currentUsage, String appId) {
  // If the app is not in the current usage stats, it means it was closed.
  return !currentUsage.containsKey(appId);
}

String? checkIfAnyAppHasBeenOpened(
  Map<String, UsageInfo> currentUsage,
  Map<String, UsageInfo> previousUsage,
  Map<String, AppInfoModel> monitoredApps,
) {
  for (String appId in monitoredApps.keys) {
  
    if (currentUsage.containsKey(appId) && previousUsage.containsKey(appId)) {
      UsageInfo currentAppUsage = currentUsage[appId]!;
      UsageInfo previousAppUsage = previousUsage[appId]!;
   
      if (currentAppUsage.lastTimeUsed != previousAppUsage.lastTimeUsed) {
       
        if (currentAppUsage.totalTimeInForeground ==
            previousAppUsage.totalTimeInForeground) {
          
          return appId;
        }
      }
    }
  }
  return null;
}
