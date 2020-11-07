
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';




class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  final bool day;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
    this.day
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: day?ProjectColors.bgIconDay:ProjectColors.bgIconDark,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
          color: day?ProjectColors.bgIconDay:ProjectColors.bgIconDark,
        ),
      ),
    );
  }
}
