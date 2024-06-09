// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppInfoModel {
  bool? locked;
  final String? screenTime;
  final String? appName;
  final String? appPackage;
  final String? lastUsedTime;
  AppInfoModel({
    this.locked,
    this.screenTime,
    this.appName,
    this.appPackage,
    this.lastUsedTime,
  });

  AppInfoModel copyWith({
    bool? locked,
    String? screenTime,
    String? appName,
    String? appPackage,
    String? lastUsedTime,
  }) {
    return AppInfoModel(
      locked: locked ?? this.locked,
      screenTime: screenTime ?? this.screenTime,
      appName: appName ?? this.appName,
      appPackage: appPackage ?? this.appPackage,
      lastUsedTime: lastUsedTime ?? this.lastUsedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locked': locked,
      'screentime': screenTime,
      'appname': appName,
      'apppackage': appPackage,
      'lastusedtime': lastUsedTime,
    };
  }

  factory AppInfoModel.fromMap(Map<String, dynamic> map) {
    return AppInfoModel(
      locked: map['locked'] != null ? map['locked'] as bool : null,
      screenTime:
          map['screentime'] != null ? map['screentime'] as String : null,
      appName: map['appname'] != null ? map['appname'] as String : null,
      appPackage:
          map['apppackage'] != null ? map['apppackage'] as String : null,
      lastUsedTime:
          map['lastusedtime'] != null ? map['lastusedtime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppInfoModel.fromJson(String source) =>
      AppInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppInfoModel(locked: $locked, screenTime: $screenTime, appName: $appName, appPackage: $appPackage, lastUsedTime: $lastUsedTime)';
  }

  @override
  bool operator ==(covariant AppInfoModel other) {
    if (identical(this, other)) return true;

    return other.locked == locked &&
        other.screenTime == screenTime &&
        other.appName == appName &&
        other.appPackage == appPackage &&
        other.lastUsedTime == lastUsedTime;
  }

  @override
  int get hashCode {
    return locked.hashCode ^
        screenTime.hashCode ^
        appName.hashCode ^
        appPackage.hashCode ^
        lastUsedTime.hashCode;
  }
}
