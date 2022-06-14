import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/constants/shared_preference_constant.dart';
import 'package:saxonmarket/controller/startup/init_data_controller.dart';
import 'package:saxonmarket/services/navigation_service.dart';
import 'package:saxonmarket/views/screens/home/home_screen.dart';
import 'package:saxonmarket/views/screens/startup/intro_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  var userData;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    bool isNewlyInstalled = getBoolAsync(NEWLY_INSTALLED, defaultValue: true);
    ref.read(initDataProvider.notifier).fetchData();

    if (isNewlyInstalled) {
      setValue(NEWLY_INSTALLED, false);
      await Future.delayed(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
                context,
                FadeRoute(page: IntroductionScreens()),
              ));
    }
    if (!mounted) return;
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(context, FadeRoute(page: HomeScreen())),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: KColor.primary,
          body: Center(
            child: Image.asset(AssetPath.appLogo),
          ),
        ));
  }
}
