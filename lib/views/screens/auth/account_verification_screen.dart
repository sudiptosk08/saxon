import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/auth/auth_controller.dart';
import 'package:saxonmarket/controller/auth/state/auth_state.dart';
import 'package:saxonmarket/views/global_components/k_text_field.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'login_screen.dart';

class AccountVerificationScreen extends StatefulWidget {
  final String? email, phone;
  const AccountVerificationScreen({Key? key, this.email, this.phone}) : super(key: key);

  @override
  _AccountVerificationScreenState createState() => _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, color: KColor.black, size: 30),
                ),
                const SizedBox(height: 30),

                Text(
                  'Account Verification',
                  style: KTextStyle.headline6.copyWith(fontWeight: FontWeight.bold, fontSize: 34),
                ),
                 const SizedBox(height: 10),
                 Text(
                  "We have sent a code to your email",
                  style: KTextStyle.bodyText1.copyWith( color: KColor.textFieldLabel,
                    fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 60),
               
                
                Form(
                  key: globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KTextField(
                        labelText: 'Code',
                        hintText: "Enter Your Code",
                        hintColor: KColor.textFieldLabel,
                        textInputType: TextInputType.number,
                        controller: codeController,
                        requiredField: true,
                        topMargin: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Resend',
                    style: KTextStyle.headline6.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: KColor.textFieldLabel),
                  ),
                ),
                const SizedBox(height: 60),
                Consumer(builder: (builder, ref, _) {
                  final authstate = ref.watch(authProvider);
                  return KButton(
                      getHeight: KSize.getHeight(context, 60),
                      getWidth: KSize.getWidth(context, 370),
                      text:authstate is AuthLoadingState ?"PLEASE WAIT" : "VERIFY",
                      containerColor: KColor.primary,
                      borderColor: KColor.primary,
                      txtcolor: KColor.white,
                      kbuttonTap: () {
                        if (!(authstate is AuthLoadingState)) {
                          ref.read(authProvider.notifier).verifyAccount(widget.email!, widget.phone!, codeController.text);
                        }
                      });
                }),
              
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Already Verified? Please ",
                          style: KTextStyle.bodyText1.copyWith(fontSize: 12, color: KColor.accentColor),
                          children: [
                            TextSpan(
                                text: "Sign In ",
                                style: KTextStyle.bodyText1.copyWith(
                                  fontSize: 12,
                                  color: KColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginScreen()));
                                  }),
                          ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
