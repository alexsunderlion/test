import 'package:clubforce/core/injection/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../route/app_router.dart';

final inject = GetIt.instance;

@injectableInit
Future<void> init() async {
  inject.registerSingleton<AppRouter>(AppRouter());
  inject.init();
  await inject.allReady();
}
