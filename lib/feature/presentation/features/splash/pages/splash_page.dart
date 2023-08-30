import 'package:clubforce/core/injection/injection_container.dart';
import 'package:clubforce/core/route/app_router.dart';
import 'package:clubforce/core/util/constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      inject<AppRouter>().push(const ArtistRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
    );
  }
}
