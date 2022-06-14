import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/controller/auth/state/user_state.dart';
import 'package:saxonmarket/controller/auth/user_controller.dart';
import 'package:saxonmarket/models/user_model.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/global_components/k_text_field.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class UpdateProfile extends ConsumerStatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends ConsumerState<UpdateProfile> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  UserModel? userData;

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    setFieldValues();
  }

  setFieldValues() async {
    userData = ref.read(userProvider.notifier).userData;

    nameController.text = userData!.name ?? '';
    addressController.text = userData!.address ?? '';
    emailController.text = userData!.email ?? '';
    phoneController.text = userData!.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // We can also use "ref" to listen to a provider inside the build method
    final userState = ref.watch(userProvider);
    return Scaffold(
        backgroundColor: KColor.white,
        appBar: KAppBar(
          leadingicon: Icons.arrow_back,
          leadiconpress: () {
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Update Profile',
                    style: KTextStyle.headline4.copyWith(color: KColor.bodyTitle),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 95,
                          height: 94,
                          decoration:
                              BoxDecoration(image: DecorationImage(image: AssetImage(AssetPath.profile)), borderRadius: BorderRadius.circular(45)),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        KTextField(
                          labelText: 'Name',
                          hintText: "Name",
                          //initialValue: userName,
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: nameController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(height: 15),
                        KTextField(
                          labelText: 'Email',
                          hintText: "Email",
                          //initialValue: email,
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: emailController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(height: 15),
                        KTextField(
                          labelText: 'Phone',
                          hintText: 'Phone',
                          //initialValue:phone,
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: phoneController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(height: 15),
                        KTextField(
                          labelText: 'Address',
                          hintText: "Address",
                          //initialValue: address,
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: addressController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: KSize.getHeight(context, 15),
            right: KSize.getHeight(context, 15),
            top: KSize.getHeight(context, 5),
            bottom: KSize.getHeight(context, 15),
          ),
          child: KButton(
            getWidth: KSize.getWidth(context, 180),
            getHeight: KSize.getHeight(context, 60),
            text: userState is UserLoadingState ? "Please wait..." : "UPDATE PROFILE",
            containerColor: userState is UserLoadingState ? KColor.grey350 : KColor.primary,
            borderColor: KColor.primary,
            kbuttonTap: () {
              if (!(userState is UserLoadingState)) {
                ref
                    .read(userProvider.notifier)
                    .updateProfile(nameController.text, emailController.text, phoneController.text, addressController.text);
              }
            },
            txtcolor: KColor.white,
          ),
        ));
  }
}
