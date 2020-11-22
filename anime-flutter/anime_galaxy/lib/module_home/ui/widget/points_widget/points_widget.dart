
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:anime_galaxy/generated/l10n.dart';

// ignore: must_be_immutable
class PointsWidget extends StatelessWidget {
  final int points;
   String memberType;
  PointsWidget({this.points}){
    memberType = points < 200 ?
                      S.current.ordinary:
                      points < 500 ?
                            S.current.pronze :
                            points < 1000 ?
                               S.current.silver :
                               S.current.gold;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Row(

        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).member+' $memberType',
                style: TextStyle(
                    fontSize: 10,
                  fontFamily:'Roboto',
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
                    percent: 0.001 * points,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Color(0xfff77f00),
                  ),
                ),
              ),

            ],
          ),
          Column(
            children: [
              ImageIcon(
                AssetImage('assets/images/trophy.png'),
                color: ProjectColors.ThemeColor,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  '$points '+ S.of(context).point,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 10,
                    fontFamily:'Roboto',
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
