import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/progress_dialog/PregressDialog.dart';
import 'package:eds_survey/di/bindings/Bindings.dart';
import 'package:eds_survey/ui/home/HomeScreen.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: isUserAlreadyLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return const SimpleProgressDialog();

          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {

            bool loggedIn = snapshot.requireData;
            if (loggedIn) {
              // User Already logged In, navigate to main screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.offNamed(Routes.home);
              });
            } else {
              //navigate to login screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.offNamed(Routes.login);
              });
            }
            return const SimpleProgressDialog(); // Return progress dialog while waiting for navigation
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }

  Future<bool> isUserAlreadyLoggedIn() async {
    await SurveyBinding().dependencies();
    PreferenceUtil preferenceUtil = Get.find();
    return preferenceUtil.getToken().isNotEmpty;
  }
}
