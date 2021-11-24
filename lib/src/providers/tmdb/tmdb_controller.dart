import 'package:flutter/widgets.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbController extends ChangeNotifier{

  List _nowPlayingMovies = [];
  List get nowPlayingMovies => _nowPlayingMovies;

  List _trailer = [];
  List get trailer => _trailer;

  int _index = 0;
  int get index => _index;

  TMDB? tmdbWithCustomLogs;

  loadMovieData(String strApiKey, String strToken) async {
    tmdbWithCustomLogs = TMDB(ApiKeys(strApiKey, strToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));

    Map nowPlayResult = await tmdbWithCustomLogs!.v3.movies.getNowPlaying();

    _nowPlayingMovies = nowPlayResult['results'];

    notifyListeners();
  }

  getTrailer(int index, List movieList) async {


    Map videos = await tmdbWithCustomLogs!.v3.movies.getVideos(movieList[index]['id']);

    _trailer = videos['results'];

    print('key : ${_trailer[0]['key']}');

  }
}