import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class PointsWidget extends StatelessWidget {
  final int points;
   String memberType;
  PointsWidget({this.points}){
    memberType = points<80 ? 'برونزي' : points < 90 ? 'فضي' : 'ذهبي';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff3d3e4c),
      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
      child: Row(

        children: [
          Column(
            children: [
              Icon(
                Icons.star,
                color: Color(0xfff77f00),
              ),
              Text(
                '$points نقطة ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'عضو  $memberType',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child:   new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width *0.8,
                  animation: true,
                  lineHeight: 10.0,
                  animationDuration: 1000,
                  percent: 0.01 * points,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Color(0xfff77f00),
                ),
              ),

            ],
          ),

        ],
      ),
    ) ;
  }
}
