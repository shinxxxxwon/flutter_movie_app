import 'package:flutter/widgets.dart';

class BookingController extends ChangeNotifier{

  var seat;
  var seatStatus;

  var date;
  var dateStatus;

  var movie;
  var movieStatus;

  DateTime currentDate = DateTime.now();

  String? _strDayWeek = '';
  String? get strDayWeek => _strDayWeek;

  int? _nDateIndex = 0;
  int? get nDateIndex => _nDateIndex;

  int seatSelect = 0;

  List<int> seatNum = [];

  List<String> reservationNumber = [];

  initBooking(int length){
    seat = List.filled(200, false, growable: true);
    date = List.generate(7, (_) => List.from(seat));
    movie = List.generate(length, (_) => List.from(date.map((v) => List.from(v))));

    seatStatus = List.filled(200, 0, growable: true);
    dateStatus = List.generate(7, (_) => List.from(seatStatus));
    movieStatus = List.generate(length, (_) => List.from(dateStatus.map((v) => List.from(v))));
    notifyListeners();
  }

  getStrDayWeek(String str){
    _strDayWeek = str;
    notifyListeners();
  }

  getDateIndex(int n){
    _nDateIndex = n;
    notifyListeners();
  }

  incrementSeatSelect(){
    seatSelect++;
    notifyListeners();
  }

  decrementSeatSelect(){
    if(seatSelect > 0){
      seatSelect--;
      notifyListeners();
    }
  }

  initSeatSelect(){
    seatSelect = 0;
    notifyListeners();
  }

  addSeatNum(int index){
    seatNum.add(index);
    notifyListeners();
  }

  removeSeatNum(int index){
    seatNum.remove(index);
    notifyListeners();
  }

  initSeatNum(){
    seatNum.clear();
    notifyListeners();
  }

  addReservationNumber(String str){
    reservationNumber.add(str);
    notifyListeners();
  }

  removeReservationNumber(String str){
    reservationNumber.remove(str);
    notifyListeners();
  }

}