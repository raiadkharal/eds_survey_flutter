import 'package:eds_survey/ui/home/HomeViewModel.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/ui/login/LoginViewModel.dart';
import 'package:eds_survey/ui/priorities/PrioritiesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PrioritiesViewModel(),),
      ChangeNotifierProvider(create: (context) => LoginViewModel(),),
      ChangeNotifierProvider(create: (context) => HomeViewModel(),)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDS Survey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
