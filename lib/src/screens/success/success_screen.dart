import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sjw_v1/src/screens/success/components/success_background.dart';
import 'package:sjw_v1/src/screens/success/components/success_rubber_sheet.dart';

class SuccessScreen extends StatelessWidget {
  final Size? size;
  final int? index;

  SuccessScreen({this.size, this.index});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          //Success Background
          SuccessBackground(index: this.index!, size: this.size!,),

          //Show Success Rubber Sheet
          SuccessRubberSheet(size: this.size!, index: this.index!,),

        ],
      ),
    );
  }
}
