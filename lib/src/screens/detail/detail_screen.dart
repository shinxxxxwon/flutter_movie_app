import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rubber/rubber.dart';
import 'package:sjw_v1/src/providers/detail/detail_controller.dart';
import 'package:sjw_v1/src/screens/detail/conponents/detail_background.dart';
import 'package:sjw_v1/src/screens/detail/conponents/detail_buy_button.dart';
import 'package:sjw_v1/src/screens/detail/conponents/detail_rubber_sheet.dart';
import 'package:sjw_v1/src/widgets/custom_back_button.dart';


class DetailScreen extends StatefulWidget {
  final int? index;
  final Size? size;

  DetailScreen({this.index, this.size});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RubberAnimationController rubberAnimationSheetController = RubberAnimationController(
        vsync: this,
        lowerBoundValue:
        AnimationControllerValue(pixel: widget.size!.height * 0.75),
        dismissable: false,
        upperBoundValue: AnimationControllerValue(percentage: 0.9),
        duration: Duration(milliseconds: 300),
        springDescription: SpringDescription.withDampingRatio(
          mass: 1,
          stiffness: Stiffness.LOW,
          ratio: DampingRatio.MEDIUM_BOUNCY,
        ));

    context.read<DetailController>().setRubberAnimation(rubberAnimationSheetController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          //Detail Background
          DetailBackground(size: widget.size!, index: widget.index!,),

          //Show Detail RubberSheet
          DetailRubberSheet(size: widget.size!, index: widget.index!,),

          //Buy Button
          DetailBuyButton(size: widget.size!, index: widget.index!,),

          //Custom Back Button
          CustomBackButton(size: widget.size!,),

        ],
      ),
    );
  }
}
