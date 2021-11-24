import 'package:flutter/widgets.dart';
import 'package:rubber/rubber.dart';

class DetailController extends ChangeNotifier{

  RubberAnimationController? rubberAnimationSheetController ;
  ScrollController? rubberSheetScrollController = ScrollController();

  setRubberAnimation(RubberAnimationController rubberAnimationController){
    rubberAnimationSheetController = rubberAnimationController;
    notifyListeners();
  }

}