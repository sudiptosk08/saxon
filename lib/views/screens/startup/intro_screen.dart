import 'package:flutter/cupertino.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/views/screens/auth/login_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class IntroductionScreens extends StatefulWidget {
  const IntroductionScreens({Key? key}) : super(key: key);

  @override
  _IntroductionScreensState createState() => _IntroductionScreensState();
}

class _IntroductionScreensState extends State<IntroductionScreens> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      descriptionPadding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      pageColor: KColor.primary,
      bodyAlignment: Alignment.topLeft,
      imageAlignment: Alignment.bottomLeft,
      imagePadding: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
    );
    return IntroductionScreen(
      key: introKey,
      onDone: () {
        // When done button is press
        _onIntroEnd(context);
      },
      onSkip: () {
        // You can also override onSkip callback
        _onIntroEnd(context);
      },
      showSkipButton: true,
      showNextButton: false,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.normal, color: KColor.secondary)),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.normal, color: KColor.secondary)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(30.0, 10.0),
          activeColor: KColor.white,
          color: KColor.white,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
      dotsContainerDecorator: const ShapeDecoration(
        color: KColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      ),
      pages: [
        PageViewModel(
            titleWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                ),
                child: Text(
                  "Free \nDelivery",
                  style: KTextStyle.headline5.copyWith(
                    fontSize: 32,
                    color: KColor.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.38,
                  ),
                ),
              ),
            ),
            //title: "Free \n Delivery",
            bodyWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
                style: KTextStyle.bodyText1.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: KColor.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            image: Image.asset(
              AssetPath.deliveryTruck,
              height: KSize.getHeight(context, 175),
              color: KColor.white,
            ),
            decoration: pageDecoration),
        PageViewModel(
            titleWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                ),
                child: Text(
                  "Secure \nPayment",
                  style: KTextStyle.headline5.copyWith(
                    fontSize: 32,
                    color: KColor.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.38,
                  ),
                ),
              ),
            ),
            //title: "Secure \n Payment",
            bodyWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
                style: KTextStyle.bodyText1.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: KColor.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            // body:
            //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
            image: Image.asset(
              AssetPath.creditCard,
              height: KSize.getHeight(context, 175),
              color: KColor.white,
            ),
            decoration: pageDecoration),
        PageViewModel(
            titleWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                ),
                child: Text(
                  "45 Money \nReturn",
                  style: KTextStyle.headline5.copyWith(
                    fontSize: 32,
                    color: KColor.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.38,
                  ),
                ),
              ),
            ),
            //   title: "45 Money \nReturn",
            bodyWidget: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
                style: KTextStyle.bodyText1.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: KColor.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            image: Image.asset(
              AssetPath.handWithDollar,
              height: KSize.getHeight(context, 175),
              color: KColor.white,
            ),
            decoration: pageDecoration),
      ],
    );
  }
}
