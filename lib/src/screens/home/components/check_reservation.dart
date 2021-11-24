import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';
import 'package:sjw_v1/src/providers/reservation/reservation_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';

class CheckReservation extends StatelessWidget {
  final Size? size;

  CheckReservation({this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 90,
      child: InkWell(
        onTap: () {
          _showSearchReservation(context);
        },
        child: Icon(
          Icons.search,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  _showSearchReservation(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController _reservController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                '예약 번호 조회',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Container(
                width: this.size!.width * 0.2,
                height: this.size!.height * 0.1,
                child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _reservController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return '예약번호를 입력하세요';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '예약번호 입력',
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                if (context
                                    .read<ReservationController>()
                                    .reservation
                                    .containsKey(_reservController.text)) {
                                  _showReservation(context, _reservController.text);
                                } else {
                                  _showNoSearchReservation(context);
                                }
                              },
                              child: Text(
                                '확인',
                              ),
                            ),

                            SizedBox(width: this.size!.width * 0.02,),

                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '취소',
                              ),
                            ),

                          ],
                        ),
                      ],
                    )),
              ));
        });
  }

  _showReservation(BuildContext context, String key) {
    int index =
        context.read<ReservationController>().reservation[key]!['index'];
    int dateIndex =
        context.read<ReservationController>().reservation[key]!['dateIndex'];
    List<int> seatNum =
        context.read<ReservationController>().reservation[key]!['seatNum'];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '예약 확인',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Container(
                width: this.size!.width * 0.7,
                height: this.size!.height * 0.25,
              child: Column(
                children: <Widget>[
                  Container(
                    width: this.size!.width * 0.7,
                    height: this.size!.height * 0.2,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: this.size!.width * 0.2,
                          height: this.size!.height * 0.2,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'http://image.tmdb.org/t/p/w500' +
                                  context
                                      .read<TmdbController>()
                                      .nowPlayingMovies[index]['poster_path'],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: this.size!.width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //예약 번호 출력
                            Container(
                              alignment: Alignment.centerLeft,
                              height: this.size!.height * 0.02,
                              child: Text('$key',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),

                            Divider(
                              thickness: 1.5,
                            ),

                            //날짜 출력
                            Container(
                              alignment: Alignment.centerLeft,
                              height: this.size!.height * 0.02,
                              child: Text(
                                  '${context.read<ReservationController>().reservation[key]!['date']}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),

                            Divider(
                              thickness: 1.5,
                            ),

                            //제목 출력
                            Container(
                              alignment: Alignment.centerLeft,
                              height: this.size!.height * 0.05,
                              child: Text(
                                  '${context.read<TmdbController>().nowPlayingMovies[index]['title']}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),

                            Divider(
                              thickness: 1.5,
                            ),

                            //인원수 출력
                            Container(
                              alignment: Alignment.centerLeft,
                              height: this.size!.height * 0.02,
                              child: Text(
                                  '${context.read<ReservationController>().reservation[key]!['count']} 명',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),

                            Divider(
                              thickness: 1.5,
                            ),

                            //좌석 번호 출력
                            Container(
                              alignment: Alignment.centerLeft,
                              height: this.size!.height * 0.02,
                              child: Text(
                                  '${context.read<ReservationController>().reservation[key]!['seat']}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ),

                            Divider(
                              thickness: 1.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text('확인'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text('예약 취소'),
                        onPressed: () {
                          print(seatNum);
                          for (int i = 0; i < seatNum.length; i++) {
                            context.read<BookingController>().movie[index]
                            [dateIndex][seatNum[i]] = false;
                            context.read<BookingController>().movieStatus[index]
                            [dateIndex][seatNum[i]] = 0;
                          }

                          context
                              .read<ReservationController>()
                              .reservation
                              .remove(key);

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showNoSearchReservation(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '예약 확인',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Container(
              width: 300,
              height: 150,
              child: Column(
                children: <Widget>[
                  Text('예약번호가 올바르지 않습니다.'),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('확인'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
