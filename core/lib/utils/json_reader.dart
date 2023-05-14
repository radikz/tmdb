import 'dart:io';

import 'package:flutter/foundation.dart';

@visibleForTesting
String readJson(String name, {String? package}) {
  var dir = Directory.current.path;
  print("package: $package");
  String packageName = package != null ? "/$package" : "";
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir$packageName/test/$name').readAsStringSync();
}
