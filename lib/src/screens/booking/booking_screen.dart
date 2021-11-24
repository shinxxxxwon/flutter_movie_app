import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sjw_v1/src/screens/booking/components/booking_app_bar.dart';
import 'package:sjw_v1/src/screens/booking/components/booking_button.dart';
import 'package:sjw_v1/src/screens/booking/components/booking_date.dart';
import 'package:sjw_v1/src/screens/booking/components/booking_location.dart';

import 'components/booking_seat.dart';

class BookingScreen extends StatelessWidget {
  final int? index;

  BookingScreen({this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: <Widget>[
              //Booking App bar
              BookingAppBar(size: size, index: this.index!,),

              //Booking Date
              BookingDate(size: size,),

              //Location
              SizedBox(height: 30,),
              BookingLocation(),

              //Booking Seat
              BookingSeat(size: size, index: this.index!,),

              //Bookign Button
              //BookingButton(index: this.index!, size: size,),

            ],
          ),
        ),
      ),
    );
  }
}
