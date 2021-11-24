import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

class BookingAppBar extends StatelessWidget {
  final int? index;
  final Size? size;

  BookingAppBar({this.index, this.size});

  @override
  Widget build(BuildContext context) {
    List movieList = context.read<TmdbController>().nowPlayingMovies;

    return Expanded(
      flex: 15,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0 / 2),
        child: Container(
          width: this.size!.width,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: this.size!.height * 0.06 ,
                child: Text(
                  movieList[this.index!]['title'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Positioned(
                top: 0,
                left: this.size!.width * 0.03,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
