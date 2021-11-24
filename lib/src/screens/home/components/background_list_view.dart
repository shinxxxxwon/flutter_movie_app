import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/home/home_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

class BackgroundListView extends StatelessWidget {
  final Size? size;

  BackgroundListView({this.size});

  @override
  Widget build(BuildContext context) {

    ScrollController initController = ScrollController();
    context.read<HomeController>().initBackgroundScrollController(initController);

    ScrollController backgroundScrollController = context.read<HomeController>().backgroundScrollController!;

    List movieList = context.read<TmdbController>().nowPlayingMovies;

    return ListView.builder(
      controller: backgroundScrollController,
      //padding: EdgeInsets.zero,
      reverse: true,
      itemCount: movieList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return Container(
          width: this.size!.width,
          height: this.size!.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                left: -this.size!.width / 3,
                right: -this.size!.width / 3,
                child: Image(
                  image: NetworkImage(
                    'http://image.tmdb.org/t/p/w500' + movieList[index]['poster_path']
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.95),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 0.9],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
