import 'package:auto_route/auto_route.dart';
import 'package:clubforce/core/injection/injection_container.dart';
import 'package:clubforce/core/route/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(home: WrappedRoute(child: ArtistPage()),);
    return MaterialApp.router(
      title: 'Club Force',
      debugShowCheckedModeBanner: false,
      routerDelegate: AutoRouterDelegate(inject<AppRouter>()),
      routeInformationParser: inject<AppRouter>().defaultRouteParser(),
    );
  }
}
