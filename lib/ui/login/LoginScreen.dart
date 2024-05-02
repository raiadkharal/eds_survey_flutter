import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/progress_dialogs/PregressDialog.dart';
import 'package:eds_survey/di/bindings/Bindings.dart';
import 'package:eds_survey/ui/home/HomeScreen.dart';
import 'package:eds_survey/ui/login/LoginViewModel.dart';
import 'package:eds_survey/ui/market_visit/customer_service/CustomerServiceScreen.dart';
import 'package:eds_survey/ui/priorities/PrioritiesScreen.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/buttons/CustomButton.dart';
import '../../components/textfields/CustomPasswordField.dart';
import '../../components/textfields/CustomTextField.dart';
import '../../utils/Colors.dart';
import '../../utils/Utils.dart';

class LoginScreen extends GetView<LoginViewModel> {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: FutureBuilder(
        future: SurveyBinding().dependencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // if (controller.isUserAlreadyLoggedIn()) {
            //   navigateToMainScreen(context);
            // }
            // setObservers(context);
            return Stack(
              children: [
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        key: const ValueKey("email"),
                        hintText: "Email",
                        obscureText: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                        onSave: (value) {
                          _email = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomPasswordField(
                        key: const ValueKey("password"),
                        hintText: "Password",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        onSave: (password) {
                          _password = password;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => CustomButton(
                          onTap: () {

                            //TODO- unComment this after testing
                            // final validity = _formKey.currentState?.validate();
                            // if (validity!) {
                            //   _formKey.currentState?.save();
                            //   controller.login(
                            //     _email,
                            //     _password,
                            //         (success) => navigateToMainScreen(context),
                            //   );
                            // }
                            navigateToMainScreen(context);
                          },
                          fontSize: 22,
                          enabled: controller.isLoading.isFalse,
                          text: "Sign In")),
                    ],
                  ),
                ),
                Obx(() =>
                controller.isLoading.value
                    ? const SimpleProgressDialog()
                    : const SizedBox(),)
              ],
            );
          } else {
            return const SimpleProgressDialog();
          }
        },
      ),
    );
  }

  void setObservers(BuildContext context) {
    // ever(
    //   controller.isLoading,
    //   (value) {
    //     if (value) {
    //       showProgressDialog(context);
    //     } else {
    //       Navigator.of(context).pop();
    //     }
    //   },
    // );
  }

  navigateToMainScreen(BuildContext context) {
   Get.offAndToNamed(Routes.home);
    // Get.to(PrioritiesScreen(outletId: 0));
  }
}
