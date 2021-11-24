import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RegisterBackground extends StatelessWidget {
  final Size? size;

  RegisterBackground({this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.size!.height * 0.1,
      left: this.size!.width * 0.1,
      child: Image(
        image: AssetImage('assets/images/cinema_logo.png'),
      ),
    );
  }
}
