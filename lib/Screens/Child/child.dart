import 'package:kidzo_app/Screens/packages/appInformation.dart';
import 'package:kidzo_app/Screens/packages/lockedApps.dart';

class Children {
  String userId;
  String name;
  String email;
  String code;
  String latitude;
  String longitude;
  String parentid;
  List<Appinformation> appinformation;
  String password;
  bool screenLock;
  String token;
  List<Lockedapps> lockedapps;

  Children(
      this.name,
      this.email,
      this.appinformation,
      this.code,
      this.latitude,
      this.longitude,
      this.userId,
      this.parentid,
      this.password,
      this.screenLock,
      this.token,
      this.lockedapps);

  Map<String, dynamic> toJSON() {
    return {
      'id': userId,
      'name': name,
      'email': email,
      'password': password,
      'parentid': parentid,
      'Parentcode': code,
      'latitude': latitude,
      'longitude': longitude,
      'appinfo': appinformation.map((e) => e.toJson()).toList(),
      'screenlocked': screenLock,
      'token': token,
      'lockedapps': lockedapps
    };
  }
}
