import 'package:flutter/widgets.dart';

class HomeController extends ChangeNotifier{

  ScrollController? backgroundScrollController;
  ScrollController? movieScrollController;

  double _movieItemWidth = 0;
  double get movieItemWidth => _movieItemWidth;

  void getMovieItemWidth(Size size){
    _movieItemWidth = size.width / 2 + 48;
    notifyListeners();
  }

  initBackgroundScrollController(ScrollController ctr){
    backgroundScrollController = ctr;
    notifyListeners();
  }

  initMovieScrollController(ScrollController ctr){
    movieScrollController = ctr;
    notifyListeners();
  }
}