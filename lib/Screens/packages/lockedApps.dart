class Lockedapps {
  String appName;
  String appPackage;
  Lockedapps(this.appName, this.appPackage);

  Map<String, dynamic> toJson() {
    return {'appname': appName, 'package': appPackage};
  }
}
