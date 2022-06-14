import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/auth/auth_controller.dart';
import 'package:saxonmarket/controller/auth/state/auth_state.dart';
import 'package:saxonmarket/views/global_components/k_text_field.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/screens/auth/signup_screen.dart';
import 'package:saxonmarket/views/screens/home/home_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      // appBar: KAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () => Navigator.of(context).pop(),
                //   child: const Icon(
                //     Icons.arrow_back,
                //     color: KColor.black,
                //     size: 30,
                //   ),
                // ),
                const SizedBox(height: 30),
                Text(
                  'Log in',
                  style: KTextStyle.headline6.copyWith(fontWeight: FontWeight.bold, fontSize: 34),
                ),
                const SizedBox(height: 60),
                Form(
                  key: globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      KTextField(
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        hintColor: KColor.textFieldLabel,
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        requiredField: true,
                        topMargin: 4,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      KTextField(
                        labelText: 'Password',
                        hintText: "•••••••••••",
                        hintColor: KColor.textFieldLabel,
                        textInputType: TextInputType.text,
                        controller: passwordController,
                        requiredField: true,
                        topMargin: 4,
                        isPasswordField: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final authState = ref.watch(authProvider);
                    return KButton(
                      getWidth: KSize.getWidth(context, 365),
                      getHeight: KSize.getHeight(context, 60),
                      text: authState is AuthLoadingState ? "Please wait..." : "LOGIN",
                      kbuttonTap: () {
                        if (!(authState is AuthLoadingState)) {
                          // if (_formKey.currentState!.validate())
                          ref.read(authProvider.notifier).login(emailController.text, passwordController.text);
                        }
                      },
                      txtcolor: KColor.white,
                      containerColor: authState is AuthLoadingState ? KColor.grey350 : KColor.primary,
                      borderColor: KColor.primary,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style: KTextStyle.bodyText1.copyWith(fontSize: 12, color: KColor.accentColor),
                          children: [
                            TextSpan(
                                text: "Sign Up ",
                                style: KTextStyle.bodyText1.copyWith(
                                  fontSize: 12,
                                  color: KColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const SignUpScreen()));
                                  }),
                          ])),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Center(
                    child: Text(
                      'Continue as guest',
                      style: KTextStyle.bodyText1.copyWith(fontSize: 12, color: KColor.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
