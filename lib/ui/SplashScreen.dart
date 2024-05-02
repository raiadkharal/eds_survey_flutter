import 'package:eds_survey/di/bindings/Bindings.dart';
import 'package:eds_survey/ui/home/HomeScreen.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: isUserAlreadyLoggedIn(), builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return Container(color: Colors.white,child: const Icon(Icons.accessible_forward,size: 100,),);
      }else{
        bool userLoggedIn=snapshot.requireData;
        if(userLoggedIn){
          Get.to(HomeScreen());
        }else{
          Get.to(LoginScreen());
        }
        return const SizedBox();
      }
    },);
  }

  Future<bool> isUserAlreadyLoggedIn() async{
    await SurveyBinding().dependencies();
    PreferenceUtil preferenceUtil = await PreferenceUtil.getInstance();
    return preferenceUtil.getToken().isNotEmpty;
  }

}
