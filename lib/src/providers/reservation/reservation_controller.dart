import 'package:flutter/widgets.dart';

class ReservationController extends ChangeNotifier{

  Map<String, Map<String, dynamic>> reservation = Map();

  setReservation(String key, Map<String, dynamic> value){
    reservation[key] = value;
    notifyListeners();
  }
}