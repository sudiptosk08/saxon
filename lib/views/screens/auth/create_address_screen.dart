import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/global_components/k_text_field.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({Key? key}) : super(key: key);

  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddressScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();

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
        appBar: KAppBar(
          leadingicon: Icons.arrow_back,
          leadiconpress: () {
            Navigator.pop(context);
          },
          cartIconRequired: false,
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
                    'Create Address',
                    style: KTextStyle.headline6
                        .copyWith(color: KColor.bodyTitle, fontSize: 33),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        KTextField(
                          labelText: 'Name',
                          hintText: 'Enter Your Name',
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: nameController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        KTextField(
                          labelText: 'Address',
                          hintText: 'Enter Your Address',
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: addressController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        KTextField(
                          labelText: 'City',
                          hintText: 'Enter Your City',
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: cityController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        KTextField(
                          labelText: 'State',
                          hintText: 'Enter Your State',
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.text,
                          controller: stateController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        KTextField(
                          labelText: 'Postal Code',
                          hintText: 'Enter Your Postal Code',
                          hintColor: KColor.textFieldLabel,
                          textInputType: TextInputType.number,
                          controller: postalcodeController,
                          requiredField: true,
                          topMargin: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
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
            text:
                "CREATE NEW ADDRESS", // authState is AuthLoadingState ? "PLEASE WAIT" :
            containerColor: KColor.primary,
            borderColor: KColor.primary,
            kbuttonTap: () {
              if (nameController.text == "") {
                toast("Plesae enter name!", bgColor: KColor.red);
              } else if (addressController.text == "") {
                toast("Plesae enter address!", bgColor: KColor.red);
              } else if (cityController.text == "") {
                toast("Plesae enter city!", bgColor: KColor.red);
              } else if (stateController.text == "") {
                toast("Plesae enter state!", bgColor: KColor.red);
              } else if (postalcodeController.text == "") {
                toast("Plesae enter postal code!", bgColor: KColor.red);
              } else {
                Navigator.pop(context);
              }
              // Navigator.push(context, CupertinoPageRoute(builder: (context) => const AccountVerificationScreen()));
            },
            txtcolor: KColor.white,
          ),
        ));
  }
}
