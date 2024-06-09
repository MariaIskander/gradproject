import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kidzo_app/Re-usable_Component/customprint.dart';
import 'package:kidzo_app/Screens/App/appLock.dart';
import 'package:kidzo_app/Screens/App/schedule_reminder.dart';
import 'package:kidzo_app/Screens/home/appusage/appUsage.dart';
import 'package:kidzo_app/Screens/App/lockScreen.dart';
import 'package:kidzo_app/Screens/login/imports.dart';
import 'package:kidzo_app/Screens/signup/imports.dart';
import 'package:kidzo_app/widget/catergorycard.dart';

import '../packages/app_info_model.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {super.key,
      this.isScreenLocked,
      this.appsInfo,
      this.lat,
      this.long,
      this.childId});
  double? lat, long;
  List<AppInfoModel>? appsInfo;
  bool? isScreenLocked;
  String? childId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? gmc;
  StreamSubscription<Position>? positionStream;
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(43.5320733, -120.2697067), zoom: 16);

  getLocatinPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse) {
      printFunction("WhileInUse");
      Position position = await Geolocator.getCurrentPosition();
      List<Marker> markers = [
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(widget.lat!, widget.long!),
        )
      ];
      positionStream = Geolocator.getPositionStream().listen(
        (Position? position) {
          markers.add(Marker(
              markerId: const MarkerId('1'),
              position: LatLng(widget.lat!, widget.long!)));
          gmc!.animateCamera(
              CameraUpdate.newLatLng(LatLng(widget.lat!, widget.long!)));

          setState(() {});
        },
      );
    }
  }

  @override
  void initState() {
    getLocatinPermission();
    super.initState();
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(widget.lat!, widget.long!),
      )
    ];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
            width: double.infinity,
            child: GoogleMap(
              myLocationButtonEnabled: true,
              markers: markers.toSet(),
              initialCameraPosition: cameraPosition,
              mapType: MapType.satellite,
              onMapCreated: (mapcontroller) {
                gmc = mapcontroller;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage("assets/images/Rectangle.png"),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              crossAxisCount: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              children: <Widget>[
                CategoryCard(
                  svgScr: "assets/images/AppLock (2).png",
                  title: 'Lock Apps',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AppLock(
                            appsInfo: widget.appsInfo,
                            childId: widget.childId)));
                  },
                ),
                CategoryCard(
                  svgScr: "assets/images/reminder.png",
                  title: 'Schedule Reminder',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Schedule()));
                  },
                ),
                CategoryCard(
                  svgScr: "assets/images/screenTime.png",
                  title: 'Screen Time',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ScreenLock(
                              isScreenLocked: widget.isScreenLocked,
                              childId: widget.childId,
                            )));
                  },
                ),
                CategoryCard(
                  svgScr: "assets/images/AppUsage.png",
                  title: 'App Usage',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AppUsage(
                              appsInfo: widget.appsInfo,
                            )));
                  },
                ),
                CategoryCard(
                  svgScr: "assets/images/logout (2).png",
                  title: 'Log Out',
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const WelcomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
