import 'package:saxonmarket/models/user_model.dart';

abstract class UserState {
  const UserState();

  void updateProfile(String s, String t, String u, String v) {}
}

class UserInitialState extends UserState {
  const UserInitialState();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserSuccessState extends UserState {
  final UserModel? userModel;
  const UserSuccessState(this.userModel);
}

class UserErrorState extends UserState {
  const UserErrorState();
}
