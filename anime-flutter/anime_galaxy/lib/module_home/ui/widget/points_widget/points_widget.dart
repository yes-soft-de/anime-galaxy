
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:anime_galaxy/generated/l10n.dart';

// ignore: must_be_immutable
class PointsWidget extends StatelessWidget {
  final int points;
   String memberType;
  PointsWidget({this.points}){
    memberType = points<80 ? S.current.pronze : points < 90 ? S.current.silver : 'ذهبي';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Row(

        children: [
          Column(
            children: [
              Icon(
                Icons.star,
                color: Color(0xfff77f00),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  '$points نقطة ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 10
                  ),
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
                    fontSize: 10
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RotatedBox(
                  quarterTurns: 2,
                  child:   new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width *0.8,
                    animation: true,
                    lineHeight: 10.0,
                    animationDuration: 1500,
                    percent: 0.01 * points,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Color(0xfff77f00),
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    ) ;
  }
}
