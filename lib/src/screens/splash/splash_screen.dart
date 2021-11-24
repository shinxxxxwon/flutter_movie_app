import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';
import 'package:sjw_v1/src/providers/database/database_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String apiKey = '6bdd6f36cb39f19fc91894a86183a8bd';
    final readAccessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YmRkNmYzNmNiMzlmMTlmYzkxODk0YTg2MTgzYThiZCIsInN1YiI6IjYxNGJjY2JmZDJjMGMxMDA0NTNkOTk4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1gDUXeVLFMdf092GNdmo3fORzVUOSy03n5p6iKAFftI';

    context.read<DatabaseController>().openDB();
    context.read<TmdbController>().loadMovieData(apiKey, readAccessToken);

    int length = context.watch<TmdbController>().nowPlayingMovies.length;

    context.read<BookingController>().initBooking(length);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/cinema_logo.png'),
          ),
        ),
      ),
    );
  }
}
