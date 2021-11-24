import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';

import 'booking_button.dart';

class BookingSeat extends StatefulWidget {
  final int? index;
  final Size? size;

  BookingSeat({this.index, this.size});

  @override
  _BookingSeatState createState() => _BookingSeatState();
}

class _BookingSeatState extends State<BookingSeat> {

  int? dateIndex = 0;

  int seat_select = 0;
  List<int> seat_num = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSeatStatus();
  }

  void setSeatStatus(){
    dateIndex = context.read<BookingController>().nDateIndex;

    for(int i=0; i<200; i++){
      if(context.read<BookingController>().movie[widget.index!][dateIndex!][i]){
        context.read<BookingController>().movieStatus[widget.index!][dateIndex!][i] = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dateIndex = context.watch<BookingController>().nDateIndex;

    return Expanded(
      flex: 47,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Positioned(
            top: 15,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: 48,
                  width: widget.size!.width * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: widget.size!.width * 0.55,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 6.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: widget.size!.height * 0.1,
            left: 16,
            right: 16,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 20,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: List.generate(200, (index) {
                int column = (index % 200).toInt();
                return Theme(
                  data: ThemeData(
                    primarySwatch: Colors.red,
                    unselectedWidgetColor: Colors.blueGrey,
                  ),
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: context.read<BookingController>().movie[widget.index!][dateIndex!][column],
                    onChanged: context.read<BookingController>().movieStatus[widget.index!][dateIndex!][column] == 1
                    ? null
                    : (selected){
                      setState(() {
                        if(!context.read<BookingController>().movie[widget.index!][dateIndex!][column]){
                          context.read<BookingController>().movie[widget.index!][dateIndex!][column] = true;
                          context.read<BookingController>().incrementSeatSelect();
                          context.read<BookingController>().addSeatNum(column);
                          print(dateIndex);
                        }else{
                          context.read<BookingController>().movie[widget.index!][dateIndex!][column] = false;
                          context.read<BookingController>().decrementSeatSelect();
                          context.read<BookingController>().removeSeatNum(column);
                          print(dateIndex);
                        }
                      });
                    },
                  ),
                );
              }),
            ),
          ),
          BookingButton(size: widget.size!, index: widget.index!,),
        ],
      ),
    );
  }
}


