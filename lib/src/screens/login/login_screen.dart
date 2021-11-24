import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/login/login_controller.dart';
import 'package:sjw_v1/src/screens/home/home_screen.dart';
import 'package:sjw_v1/src/screens/login/components/go_to_register.dart';
import 'package:sjw_v1/src/screens/login/components/login_background.dart';
import 'package:sjw_v1/src/screens/login/components/login_input_info.dart';

import 'components/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            //Login Background
            LoginBackground(size: size,),

            //Login Input
            LoginInputInfo(size: size),

            //Login Button
            LoginButton(size: size),

            //Go to Register Screen
            GoToRegister(size: size,),

          ],
        ),
      ),
    );
  }
}
