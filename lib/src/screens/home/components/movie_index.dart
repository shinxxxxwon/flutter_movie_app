import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';
import 'package:sjw_v1/src/screens/detail/detail_screen.dart';
import 'package:sjw_v1/src/widgets/star_rating.dart';

class MovieIndex extends StatelessWidget {
  final Size? size;
  final int? index;
  final ScrollController? movieScrollController;
  final double? movieItemWidth;

  MovieIndex(
      {this.size, this.index, this.movieScrollController, this.movieItemWidth});

  double maxMovieTranslate = 65;

  double _movieTranslate(double offset, double activeOffset) {
    double translate;
    if (this.movieScrollController!.offset + this.movieItemWidth! <=
        activeOffset) {
      translate = maxMovieTranslate;
    } else if (this.movieScrollController!.offset <= activeOffset) {
      translate = maxMovieTranslate -
          ((this.movieScrollController!.offset -
                  (activeOffset - this.movieItemWidth!)) /
              this.movieItemWidth! *
              maxMovieTranslate);
    } else if (this.movieScrollController!.offset <
        activeOffset + this.movieItemWidth!) {
      translate = ((this.movieScrollController!.offset -
                  (activeOffset - this.movieItemWidth!)) /
              this.movieItemWidth! *
              maxMovieTranslate) -
          maxMovieTranslate;
    } else {
      translate = maxMovieTranslate;
    }
    return translate;
  }

  double _movieDescriptionOpacity(double offset, double activeOffset) {
    double opacity;
    if (this.movieScrollController!.offset + this.movieItemWidth! <=
        activeOffset) {
      opacity = 0;
    } else if (this.movieScrollController!.offset <= activeOffset) {
      opacity = ((this.movieScrollController!.offset -
              (activeOffset - this.movieItemWidth!)) /
          this.movieItemWidth! *
          100);
    } else if (this.movieScrollController!.offset <
        activeOffset + this.movieItemWidth!) {
      opacity = 100 -
          (((this.movieScrollController!.offset -
                      (activeOffset - this.movieItemWidth!)) /
                  this.movieItemWidth! *
                  100) -
              100);
    } else {
      opacity = 0;
    }
    return opacity;
  }

  @override
  Widget build(BuildContext context) {
    List movieList = context.read<TmdbController>().nowPlayingMovies;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0 + 4),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AnimatedBuilder(
            animation: this.movieScrollController!,
            builder: (context, child) {
              double activeOffset = this.index! * this.movieItemWidth!;
              double translate = _movieTranslate(
                  this.movieScrollController!.offset, activeOffset);

              return SizedBox(
                height: translate,
              );
            },
          ),
          SizedBox(height: this.size!.height * 0.008),
          Container(
            width: this.size!.width * 0.5,
            height: this.size!.height * 0.1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                movieList[this.index!]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: this.size!.height * 0.01,
          ),
          StarRating(
            rating: movieList[this.index!]['vote_average'],
          ),
          Container(
            width: this.size!.width * .25,
            height: 1,
            color: Color(0xFFC62828).withOpacity(0.5),
          ),
          SizedBox(
            height: this.size!.height * .01,
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => DetailScreen(
                  index: this.index!,
                  size: this.size!,
                ),
              ),
            ),
            child: Container(
              width: this.size!.width * .25,
              height: this.size!.height * .05,
              decoration: BoxDecoration(
                  color: Color(0xFFC62828),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                  child: Text(
                '영화 예매',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
          SizedBox(
            height: this.size!.height * .01,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, a1, a2) => DetailScreen(
                  index: this.index!,
                  size: this.size!,
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Image(
                width: this.size!.width * 0.5,
                height: this.size!.height * 0.35,
                image: NetworkImage(
                    'http://image.tmdb.org/t/p/w500' +
                        movieList[this.index!]['poster_path']),
                ),
              ),
            ),
          SizedBox(height: this.size!.height * 0.01,),
          AnimatedBuilder(
            animation: this.movieScrollController!,
            builder: (context, child){
              double activeOffset = this.index! * this.movieItemWidth!;
              double opacity = _movieDescriptionOpacity(
                  this.movieScrollController!.offset, activeOffset);
              return Opacity(
                opacity: opacity / 100,
                child: Container(
                  width: 150,
                  child: Text(
                    // widget.nowPlayingMovies![widget.index!]['genre_ids'].toString(),
                    '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: this.size!.width / 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
