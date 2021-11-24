import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sjw_v1/src/screens/register/components/register_button.dart';
import 'package:sjw_v1/src/widgets/custom_back_button.dart';
import 'components/register_background.dart';
import 'components/register_input_info.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[

          //Register Background
          RegisterBackground(size: size,),

          //CustomBack Button
          CustomBackButton(size: size,),

          //Register Input
          RegisterInputInfo(size: size),

          //Register Button
          RegisterButton(size: size,),

        ],
      ),
    );
  }
}
