import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';
import 'package:sjw_v1/src/screens/success/success_screen.dart';

class BookingButton extends StatelessWidget {
  final int? index;
  final Size? size;

  BookingButton({this.index, this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 10,
          bottom: 0,
          child: Container(
            height: this.size!.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: this.size!.height * 0.08,
                  width: 150,
                  child: Center(
                    child: Text(
                      '₩ ${context.watch<BookingController>().seatSelect * 10000}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  color: Color(0xFFC62828),
                  onPressed: context.read<BookingController>().seatSelect <= 0
                  ? null
                  : (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, a1, a2) => SuccessScreen(size: this.size!, index: this.index)
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
                  ),
                  child: Container(
                    width: this.size!.width * 0.4,
                    height: this.size!.height * 0.1,
                    child: Center(
                      child: Text(
                        "결 제",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
