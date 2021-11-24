import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/booking/booking_controller.dart';
import 'package:sjw_v1/src/providers/database/database_controller.dart';
import 'package:sjw_v1/src/providers/detail/detail_controller.dart';
import 'package:sjw_v1/src/providers/home/home_controller.dart';
import 'package:sjw_v1/src/providers/login/login_controller.dart';
import 'package:sjw_v1/src/providers/logout/logout_controller.dart';
import 'package:sjw_v1/src/providers/register/register_controller.dart';
import 'package:sjw_v1/src/providers/reservation/reservation_controller.dart';
import 'package:sjw_v1/src/providers/tmdb/tmdb_controller.dart';
import 'package:sjw_v1/src/screens/login/login_screen.dart';
import 'package:sjw_v1/src/screens/splash/splash_screen.dart';


void main(){
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DatabaseController()),
      ChangeNotifierProvider(create: (_) => LoginController()),
      ChangeNotifierProvider(create: (_) => LogoutController()),
      ChangeNotifierProvider(create: (_) => RegisterController()),
      ChangeNotifierProvider(create: (_) => HomeController()),
      ChangeNotifierProvider(create: (_) => TmdbController()),
      ChangeNotifierProvider(create: (_) => DetailController()),
      ChangeNotifierProvider(create: (_) => BookingController()),
      ChangeNotifierProvider(create: (_) => ReservationController()),
    ],
    child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen(),);
        }else{
          return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen(),);
        }
      },
    );
  }
}



