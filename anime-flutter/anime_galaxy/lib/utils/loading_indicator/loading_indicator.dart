
import 'package:anime_galaxy/utils/project_colors/project_color.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        color: ProjectColors.ThemeColor,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              'Loading',
            style: TextStyle(
              color: Colors.white,
            ),
            )
          ],
        ) ,
      ) ,
    );
  }

//  (
//    child:
//  );
}
