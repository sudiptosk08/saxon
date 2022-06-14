import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/constants/shared_preference_constant.dart';
import 'package:saxonmarket/controller/auth/state/auth_state.dart';
import 'package:saxonmarket/controller/startup/init_data_controller.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';
import 'package:saxonmarket/services/navigation_service.dart';
import 'package:saxonmarket/views/screens/auth/account_verification_screen.dart';
import 'package:saxonmarket/views/screens/auth/login_screen.dart';
import 'package:saxonmarket/views/screens/home/home_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref: ref),
);

class AuthController extends StateNotifier<AuthState> {
  final Ref? ref;
  AuthController({this.ref}) : super(AuthInitialState());

  Future login(String email, String password) async {
    email = email.trim();
    Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern.toString());
    if (email == "") {
      return toast("Plesae enter email!", bgColor: KColor.red);
    } else if (!regExp.hasMatch(email)) {
      return toast("Please enter a valid email!", bgColor: KColor.red);
    } else if (password.isEmpty) {
      toast("Plesae enter password!", bgColor: KColor.red);
    } else if (password.length < 6) {
      toast("Password must be at least 6 characters long!", bgColor: KColor.red);
    } else {
      state = AuthLoadingState();

      var responseBody;
      var requestBody = {
        'email': email,
        'password': password,
        // 'app_token': await NotificationService.getToken(),
      };
      try {
        responseBody = await Network.handleResponse(
          await Network.postRequest(API.login, requestBody),
        );

        if (responseBody != null) {
          if (responseBody['message'] != null && responseBody['message'] == "User not verified") {
            toast("Verify account first");
            NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) => AccountVerificationScreen(email: email)));
            return;
          }

          if (responseBody['token'] != null) {
            state = AuthSuccessState();
            setValue(LOGGED_IN, true);
            setValue(TOKEN, responseBody['token']);
            toast("Login Successful", bgColor: KColor.green);
            ref!.read(initDataProvider.notifier).fetchData();
            NavigationService?.navigateToReplacement(CupertinoPageRoute(builder: (context) => HomeScreen()));
          }
        } else {
          state = AuthErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = AuthErrorState();
      }
    }
  }

  Future register(String name, String email, String phone, String password) async {
    email = email.trim();
    Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern.toString());
    if (name == "") {
      return toast("Plesae enter name!", bgColor: KColor.red);
    } else if (email == "") {
      return toast("Plesae enter email!", bgColor: KColor.red);
    } else if (!regExp.hasMatch(email)) {
      return toast("Please enter a valid email!", bgColor: KColor.red);
    } else if (phone == "") {
      return toast("Plesae enter phone number!", bgColor: KColor.red);
    } else if (phone.length < 11) {
      return toast("Plesae enter a valid phone number!", bgColor: KColor.red);
    } else if (password.isEmpty) {
      toast("Plesae enter password!", bgColor: KColor.red);
    } else if (password.length < 6) {
      toast("Password must be at least 6 characters long!", bgColor: KColor.red);
    } else {
      state = AuthLoadingState();
      var responseBody;
      var requestBody = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "confirm_password": password,
      };

      try {
        responseBody = await Network.handleResponse(
          await Network.postRequest(API.register, requestBody),
        );
        if (responseBody != null) {
          state = AuthSuccessState();
          toast("Registration Successful", bgColor: KColor.green);
          NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) => AccountVerificationScreen(email: email, phone: phone)));
        } else {
          state = AuthErrorState();
        }
      } catch (error, stackTrace) {
        print(error);
        print(stackTrace);
        state = AuthErrorState();
      }
    }
  }

  Future verifyAccount(String email, String phone, String verificationCode) async {
    if (verificationCode == "") {
      return toast("Plesae enter verification code!", bgColor: KColor.red);
    }

    state = AuthLoadingState();
    var responseBody;
    var requestBody = {
      "email": email,
      "phone": phone,
      "verify_code": verificationCode,
    };

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.verifyAccount, requestBody),
      );
      if (responseBody != null) {
        state = AuthSuccessState();
        toast("Account verified successfully!", bgColor: KColor.green);
        NavigationService.navigateToReplacement(CupertinoPageRoute(builder: (context) => LoginScreen()));
      } else {
        state = AuthErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = AuthErrorState();
    }
  }
}
