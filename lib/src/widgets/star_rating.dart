import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

class StarRating extends StatelessWidget {
  final num? rating;

  StarRating({this.rating});

  @override
  Widget build(BuildContext context) {


    Widget star(bool fill) {
      return Container(
        child: Icon(
          Icons.star,
          size: 18.0,
          color: fill ? Color(0xffF9B015) : Color(0xFFC62828),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if(index < (this.rating! / 2).round()) {
          return star(true);
        }
        else{
          return star(false);
        }
      }),
    );
  }
}
