import 'package:anime_galaxy/module_home/ui/widget/points_widget/points_widget.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class HomeScreen extends StatefulWidget {

  HomeScreen(
  );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return getPageLyout();
  }

  Widget getPageLyout(){

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
         color: Color(0xff272838),
          child: Column(
            children: [
              PointsWidget(
                points: 76,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
