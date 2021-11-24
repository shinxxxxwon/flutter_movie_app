import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomBackButton extends StatelessWidget {
  final Size? size;

  CustomBackButton({this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: this.size!.width * 0.04,
      top: this.size!.height * 0.05,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
