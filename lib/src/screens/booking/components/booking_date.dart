import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';

class BookingDate extends StatelessWidget {

  final Size? size;

  BookingDate({this.size});

  String _dayFormat(int dayWeek){
    switch(dayWeek){
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
      default:
        return "월";
    }
  }

  @override
  Widget build(BuildContext context) {

    int? nIndex = 0;

    return Expanded(
      flex: 13,
      child: Container(
        width: this.size!.width,
        padding: EdgeInsets.only(left: 20.0 * 1.5),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  )),
            ),
            Container(
              width: this.size!.width,
              child: ListView.builder(
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var date = context.read<BookingController>().currentDate.add(Duration(days: index));
                    return GestureDetector(
                      onTap: () {
                        context.read<BookingController>().getDateIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(0.1),
                        margin: EdgeInsets.symmetric(
                          vertical: this.size!.height * 0.02,
                          horizontal: this.size!.width * 0.02,
                        ),
                        width: 100,
                        decoration: BoxDecoration(
                          color: context.watch<BookingController>().nDateIndex == index
                              ? Colors.orange
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                  color: context.watch<BookingController>().nDateIndex == index
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            Text(
                              _dayFormat(date.weekday),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: context.watch<BookingController>().nDateIndex == index
                                    ? Colors.black
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
