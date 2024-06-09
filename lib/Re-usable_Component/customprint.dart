import 'package:flutter/foundation.dart';

void printFunction(dynamic print) {
  if (kDebugMode) {
    debugPrint('debug: $print');
  }
}
