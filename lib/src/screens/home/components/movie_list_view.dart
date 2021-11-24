import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:sjw_v1/src/providers/home/home_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

import 'movie_index.dart';

class MovieListView extends StatelessWidget {
  final Size? size;

  MovieListView({this.size});

  @override
  Widget build(BuildContext context) {

    ScrollController movieScrollController = context.read<HomeController>().movieScrollController!;

    double movieItemWidth = context.read<HomeController>().movieItemWidth;
    List movieList = context.read<TmdbController>().nowPlayingMovies;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 700),
      tween: Tween<double>(begin: 300, end: 0),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child){
        return Transform.translate(
          offset: Offset(value, 0),
          child: child,
        );
      },
      child: Container(
        height: this.size!.height * 0.8,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll){
            overScroll.disallowGlow();
            return true;
          },
          child: ScrollSnapList(
            listController: movieScrollController,
            onItemFocus: (item){},
            itemSize: movieItemWidth,
            itemCount: movieList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              return MovieIndex(
                size: this.size!,
                index: index,
                movieScrollController: movieScrollController,
                movieItemWidth: movieItemWidth,
              );
            },
          ),
        ),
      ),
    );
  }
}
