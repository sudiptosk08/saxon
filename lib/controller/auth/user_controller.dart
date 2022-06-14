import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/controller/auth/state/user_state.dart';
import 'package:saxonmarket/models/user_model.dart';
import 'package:saxonmarket/network/api.dart';
import 'package:saxonmarket/network/network_utils.dart';
import 'package:saxonmarket/services/navigation_service.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

final userProvider = StateNotifierProvider<UserController, UserState>(
  (ref) => UserController(ref: ref),
);

class UserController extends StateNotifier<UserState> {
  final Ref? ref;
  UserController({this.ref}) : super(UserInitialState());

  UserModel? userData;

  Future getAuthUser() async {
    state = UserLoadingState();
    var responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.getUser),
      );
      if (responseBody != null) {
        userData = UserModel.fromJson(responseBody['user']);
        state = UserSuccessState(userData);
      } else {
        state = UserErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = UserErrorState();
    }
  }

  Future updateProfile(String name, String email, String phone, String address) async {
    state = UserLoadingState();
    var responseBody;
    var requestBody = {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
    };

    try {
      responseBody = await Network.handleResponse(
        await Network.postRequest(API.updateProfile, requestBody),
      );
      if (responseBody != null) {
        userData = UserModel.fromJson(responseBody['user']);
        state = UserSuccessState(userData);
        toast("Profile updated successfully!", bgColor: KColor.green);
        NavigationService.popNavigate();
      } else {
        state = UserErrorState();
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      state = UserErrorState();
    }
  }

  resetUserData() {
    userData = null;
    state = UserSuccessState(userData);
  }
}
