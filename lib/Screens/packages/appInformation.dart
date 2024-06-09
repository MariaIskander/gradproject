class Appinformation {
  String appName;
  String appPackage;
  String ScreenTime;
  String lastUsedTime;
  bool locked;

  Appinformation(this.appName, this.appPackage, this.ScreenTime,
      this.lastUsedTime, this.locked);
  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appPackage': appPackage,
      'ScreenTime': ScreenTime,
      'lastUsedTime': lastUsedTime,
      'locked': locked,
    };
  }
}
