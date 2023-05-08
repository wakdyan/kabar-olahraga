import 'dart:io';

import 'package:flutter/foundation.dart';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    debugPrint('dir: $dir');
  }
  return File('$dir/test/$name').readAsStringSync();
}
