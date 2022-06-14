import 'package:flutter/material.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/screens/home/home_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class PaymentSuccessfull extends StatefulWidget {
  const PaymentSuccessfull({Key? key}) : super(key: key);

  @override
  _PaymentSuccessfullState createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
          Image(
            width: 266,
            height: 260,
            image: AssetImage(AssetPath.successfull),
            ),
          Text(
            "Congratulations",
            textAlign: TextAlign.center,
            style: KTextStyle.headline5
                .copyWith(color: KColor.primary, letterSpacing: 0.16),
          ),
          SizedBox(height: 15,),
          Text(
            
            "Your Payment Is Complete",
             textAlign: TextAlign.center,
            style: KTextStyle.bodyText2.copyWith(color: KColor.accentColor,),
          ),
           SizedBox(height: 8,),
          Text(
            "Please Check the delivery status",
             textAlign: TextAlign.center,
            style: KTextStyle.bodyText2.copyWith(color: KColor.accentColor),
          ),
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: KButton(
            
              containerColor: KColor.primary,
              borderColor: KColor.primary,
              getHeight: 55,
              getWidth: 200,
              kbuttonTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const HomeScreen()));
              },
              txtcolor: KColor.white,
              text: "CONTINUE SHOPPING",
            ),
          ),
        ],
      ),
    );
  }
}
