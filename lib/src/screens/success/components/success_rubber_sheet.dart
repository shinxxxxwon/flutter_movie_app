import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rubber/rubber.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';
import 'package:sjw_v1/src/providers/detail/detail_controller.dart';
import 'package:sjw_v1/src/providers/reservation/reservation_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';
import 'package:sjw_v1/src/screens/home/home_screen.dart';
import 'package:sjw_v1/src/widgets/star_rating.dart';

class SuccessRubberSheet extends StatelessWidget {
  final int? index;
  final Size? size;

  SuccessRubberSheet({this.size, this.index});

  List<String> clacSeatNumber(BuildContext context){
    List<String> seatName = [];

    int row = 0;
    int column = 0;
    List<int> seatList = context.read<BookingController>().seatNum;

    for(int i=0; i<seatList.length; i++){
      row = (seatList[i] / 20 + 1).toInt();
      column = (seatList[i] % 20 + 1).toInt();

      String txt = '$row 열 $column번';

      seatName.add(txt);
    }

    return seatName;
  }

  void _showDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('예매 취소',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
            content: Text('예매를 취소 하시겠습니까?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
            actions: <Widget>[
              FlatButton(
                child: Text('예'),
                onPressed: (){
                  List<int> seatList = context.read<BookingController>().seatNum;
                  int? dateIndex = context.read<BookingController>().nDateIndex;

                  for(int i=0; i<seatList.length; i++){
                    context.read<BookingController>().movie[this.index!][dateIndex!][seatList[i]] = false;
                    context.read<BookingController>().movieStatus[this.index!][dateIndex][seatList[i]] = 0;
                  }

                  context.read<BookingController>().initSeatNum();
                  context.read<BookingController>().initSeatSelect();

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, a1, a2) => HomeScreen(),
                    ),
                  );
                },
              ),

              FlatButton(
                child: Text('아니요'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {


    List movieList = context.read<TmdbController>().nowPlayingMovies;

    int year = context.read<BookingController>().currentDate.year;
    int month = context.read<BookingController>().currentDate.month;
    int day = context.read<BookingController>().currentDate.day + context.read<BookingController>().nDateIndex!;

    String strReservationNumber = year.toString() + month.toString() + day.toString() +
        this.index!.toString() + context.read<BookingController>().seatNum.first.toString();

    String date = '$month 월 $day 일';

    Map<String, dynamic> val = {
      'index': this.index!,
      'date': date,
      'count': context.read<BookingController>().seatNum.length,
      'seat': clacSeatNumber(context).join(", "),
      'dateIndex': context.read<BookingController>().nDateIndex,
      'seatNum': context.watch<BookingController>().seatNum.toList(),

  };

    context.read<ReservationController>().setReservation(strReservationNumber, val);

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
        scrollController: context.read<DetailController>().rubberSheetScrollController,
        animationController: context.read<DetailController>().rubberAnimationSheetController!,
        lowerLayer: Container(
          color: Colors.transparent,
        ),
        upperLayer: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.0),
                    ),
                  ),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(20.0),
                    controller: context.read<DetailController>().rubberSheetScrollController,
                    children: <Widget>[
                      Text(
                        movieList[this.index!]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          StarRating(rating: movieList[this.index!]['vote_average'],),
                        ],
                      ),
                      SizedBox(height: 8.0,),
                      Container(
                        width: this.size!.width,
                        height: this.size!.height * 0.25,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: this.size!.width * 0.3,
                              height: this.size!.height * 0.25,
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'http://image.tmdb.org/t/p/w500' +
                                      movieList[this.index!]['poster_path'],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0,),



                            Container(
                              width: this.size!.width * 0.6,
                              height: this.size!.height * 0.25,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: this.size!.width * 0.6,
                                    height: this.size!.height * 0.05,
                                    child: Text(
                                      '예약 번호 : ' + strReservationNumber,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: this.size!.width * 0.6,
                                    height: this.size!.height * 0.05,
                                    child: Text(
                                      '제 목 : ' + movieList[this.index!]['title'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: this.size!.width * 0.6,
                                    height: this.size!.height * 0.05,
                                    child: Text(
                                      '날 짜 : $month 월 $day 일',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: this.size!.width * 0.6,
                                    height: this.size!.height * 0.05,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '인 원 : ${context.read<BookingController>().seatNum.length} 명',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${clacSeatNumber(context).join(", ")}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.0,),
                      Container(
                        alignment: Alignment.center,
                        height: this.size!.height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 5,
                            )),
                        child: Text(
                          '교환 및 환불은 상영시간 전까지 영수증 지참\n입장지연에 따른 관람 불편을 최소화하고자\n본영화는 약 10여분 후에 시작됩니다.\n관람에티켓을 위한 사전입장을 드립니다.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 155,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0),
                                    bottom: Radius.circular(15.0),
                                  ),
                                ),
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.home,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    context.read<BookingController>().initSeatNum();
                                    context.read<BookingController>().initSeatSelect();
                                    context.read<BookingController>().addReservationNumber(strReservationNumber);
                                    print(context.read<BookingController>().reservationNumber);
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, a1, a2) =>
                                            HomeScreen(),
                                      ),
                                    );
                                  },
                                  label: Text(
                                    '홈으로',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 37,
                            ),
                            Container(
                                width: 155,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0),
                                    bottom: Radius.circular(15.0),
                                  ),
                                ),
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    _showDialog(context);
                                  },
                                  label: Text(
                                    '예매취소',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
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

