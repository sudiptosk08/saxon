import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/controller/logger/logger_controller.dart';
import 'package:saxonmarket/services/navigation_service.dart';
import 'package:saxonmarket/views/screens/startup/splash_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  // NotificationService().firebaseInitialization();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(ProviderScope(observers: [Logger()], child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: KColor.black,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      title: 'Saxon Market',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        primaryColor: KColor.primary,
        textTheme: Typography.material2018().black,
        backgroundColor: KColor.white,
        scaffoldBackgroundColor: KColor.white,
        fontFamily: GoogleFonts.montserrat().toString(),
      ),
      home: const SplashScreen(),
    );
  }
}
