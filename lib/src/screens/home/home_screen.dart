import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/home/home_controller.dart';
import 'package:sjw_v1/src/providers/reservation/reservation_controller.dart';
import 'package:sjw_v1/src/screens/home/components/background_list_view.dart';
import 'package:sjw_v1/src/screens/home/components/check_reservation.dart';
import 'package:sjw_v1/src/screens/home/components/movie_list_view.dart';
import 'package:sjw_v1/src/screens/logout/components/logout_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    context.watch<HomeController>().getMovieItemWidth(size);

    ScrollController initController = ScrollController();
    context.watch<HomeController>().initMovieScrollController(initController);

    context.watch<HomeController>().movieScrollController!.addListener(() {
      context.read<HomeController>().backgroundScrollController!
          .jumpTo(context.read<HomeController>().movieScrollController!.offset
          * (size.width / context.read<HomeController>().movieItemWidth));
    });

    if(!context.read<ReservationController>().reservation.isEmpty) {
      print('printing ${context
          .watch<ReservationController>()
          .reservation}');
    }

    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            //Background Image List
            BackgroundListView(size: size,),

            //Center Movie List
            MovieListView(size: size),

            //Custom Logout
            LogoutButton(size: size,),

            //Check Reservation
            CheckReservation(size: size,),

          ],
        ),
      ),
    );
  }
}
