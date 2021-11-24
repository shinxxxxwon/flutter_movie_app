import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sjw_v1/src/screens/register/register_screen.dart';

class GoToRegister extends StatelessWidget {
  final Size? size;

  GoToRegister({this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.size!.height * 0.72,
      left: this.size!.width * 0.25,
      child: Container(
        width: this.size!.width * 0.5,
        height: this.size!.height * 0.07,
        child: TextButton(
          child: Text(
            '회원이 아니신가요?',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, a1, a2) => RegisterScreen()));
          },
        ),
      ),
    );
  }
}
