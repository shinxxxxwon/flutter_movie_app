import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/screens/booking/booking_screen.dart';

class DetailBuyButton extends StatelessWidget {
  final Size? size;
  final int? index;

  DetailBuyButton({this.index, this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: this.size!.width * 0.9,
        height: this.size!.height * 0.08,
        margin: EdgeInsets.symmetric(vertical: this.size!.width * 0.05),
        child: FlatButton(
          color: Color(0xFFC62828),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingScreen(
                          index: this.index!,
                        )));
          },
          child: Text(
            '영화 예매',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
