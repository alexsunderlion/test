import 'dart:async';

import 'package:clubforce/app.dart';
import 'package:clubforce/core/injection/injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    runApp(const App());
  }, (error, stack) {
    debugPrintStack(label: error.toString(), stackTrace: stack);
  });
}
