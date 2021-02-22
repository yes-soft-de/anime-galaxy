import 'package:anime_galaxy/utils/project_color/project_color.dart';


import 'package:flutter/material.dart';



class CustomeButton extends StatelessWidget {
  final String txt;
  final Color borderColor;
  final Color splashColor;
  final double borderWidth;
  final TextStyle textStyle;
  final VoidCallback press;
  final Color buttonColor;
  final double raduis;

  CustomeButton({this.txt,
    this.borderColor=ProjectColors.bgButtonIhaveAccount,
    this.splashColor=Colors.grey,
    this.borderWidth=1.4,

    this.textStyle,
    this.press,
    this.buttonColor=ProjectColors.bgButtonIhaveAccount,
    this.raduis=0});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: BorderSide(
              color: borderColor,
              width: borderWidth,
              style: BorderStyle.solid)),
      splashColor: splashColor,
      color: buttonColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(txt,
            textAlign: TextAlign.center,
            style:textStyle
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
