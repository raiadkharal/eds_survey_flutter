import 'package:eds_survey/ui/home/HomeScreen.dart';
import 'package:eds_survey/ui/login/LoginViewModel.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/buttons/custom_button.dart';
import '../../components/textfields/custom_password_field.dart';
import '../../components/textfields/custom_text_field.dart';
import '../../utils/Colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    isAlreadyLoggedIn().then((value) {
      if(value){
        navigateToMainScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, loginViewModel, child) {
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
          body: Center(
            child: loginViewModel.isLoading
                ? const CircularProgressIndicator()
                : Form(
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
                        CustomButton(
                            onTap: () {
                              final validity =
                                  _formKey.currentState?.validate();
                              if (validity!) {
                                _formKey.currentState?.save();
                                loginViewModel.login(
                                  _email,
                                  _password,
                                  (success) => navigateToMainScreen(),
                                );
                              }
                            },
                            fontSize: 22,
                            enabled: true,
                            text: "Sign In")
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  navigateToMainScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }

  Future<bool> isAlreadyLoggedIn() async {
    PreferenceUtil preferenceUtil = await PreferenceUtil.getInstance();
    return preferenceUtil.getToken().isNotEmpty;
  }
}
