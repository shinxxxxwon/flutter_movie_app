import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BookingLocation extends StatelessWidget {
  const BookingLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.location_on, color: Colors.white, size: 30,),
          SizedBox(width: 8.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('SJW Cinemas', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0
              ),),
              Text('Induk Univ, Seoul, Korea', style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16.0,
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
