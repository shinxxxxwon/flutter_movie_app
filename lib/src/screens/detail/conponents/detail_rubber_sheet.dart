import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rubber/rubber.dart';
import 'package:sjw_v1/src/providers/detail/detail_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';
import 'package:sjw_v1/src/widgets/star_rating.dart';

class DetailRubberSheet extends StatelessWidget {
  final Size? size;
  final int? index;

  DetailRubberSheet({this.index, this.size});

  @override
  Widget build(BuildContext context) {

    ScrollController? rubberSheetScrollController = context.watch<DetailController>().rubberSheetScrollController;
    RubberAnimationController? rubberSheetAnimationController = context.watch<DetailController>().rubberAnimationSheetController;
    List movieList = context.watch<TmdbController>().nowPlayingMovies;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 700),
      tween: Tween<double>(begin: this.size!.height / 2, end: 0),
      builder: (context, double value, child){
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: RubberBottomSheet(
        scrollController: rubberSheetScrollController!,
        animationController: rubberSheetAnimationController!,
        lowerLayer: Container(
          color: Colors.transparent,
        ),
        upperLayer: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50.0),
                      ),
                    ),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(20.0),
                    controller: rubberSheetScrollController,
                    children: <Widget>[
                      Text(
                        movieList[this.index!]['title'],
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 8.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            movieList[this.index!]['vote_average'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          SizedBox(height: 8.0,),

                          StarRating(rating: movieList[this.index!]['vote_average'],),
                        ],
                      ),

                      SizedBox(height: 8.0,),

                      Text(
                        'Story Line',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12.0,),

                      Text(
                        movieList[this.index!]['overview'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.justify,
                      ) ,

                      SizedBox(height: 8.0,),

                      Image(
                        image: NetworkImage(
                          'http://image.tmdb.org/t/p/w500' +
                              movieList[this.index!]['poster_path'],
                        ),
                      )
                    ],
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
