import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

class DetailBackground extends StatelessWidget {
  final Size? size;
  final int? index;

  DetailBackground({this.size, this.index});

  @override
  Widget build(BuildContext context) {
    
    List movieList = context.read<TmdbController>().nowPlayingMovies;
    
    return Positioned(
      top: -48,
      bottom: 0,
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 700),
        tween: Tween<double>(begin: 0.25, end: 1),
        builder: (context, double value, child){
          return Transform.scale(scale: value, child: child,);
        },
        child: Stack(
          children: <Widget>[
            Image(
              width: this.size!.width,
              height: this.size!.height,
              fit: BoxFit.cover,
              image: NetworkImage(
                'http://image.tmdb.org/t/p/w500' +
                    movieList[this.index!]['poster_path'],
              ),
            ),
            Container(
              width: this.size!.width,
              height: this.size!.height,
              color: Colors.black.withOpacity(0.6),
            )
          ],
        ),
      ),
    );
  }
}
