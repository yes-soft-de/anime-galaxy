

import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class StyleSetting{



 static  OutlineInputBorder  getOutLineBorder({double width,Color color,double radius}){

    return OutlineInputBorder(
      borderSide: BorderSide(
        width: width,
        color:color,

      ),
      borderRadius: BorderRadius.circular(radius)
  );
  }


 static InputDecoration getInputDecorationDay({String hint,String label,Widget icon}){

    icon ??= Icon(Icons.person,color: ProjectColors.bgIconDay,);
    return InputDecoration(

      prefixIcon: IconButton(onPressed: (){},icon:icon,),
      alignLabelWithHint: true,
      hintText: hint ?? '',
      labelText: label ?? '',
      border: OutlineInputBorder(
        borderRadius:BorderRadius.circular(30),),
      focusedBorder: getOutLineBorder(width: 1,color:ProjectColors.bgIconDay,radius:30),
      enabledBorder: getOutLineBorder(width: 1.5,color:ProjectColors.bgIconDay,radius:30),
      errorBorder: getOutLineBorder(width: 1.5,color:ProjectColors.bgError,radius:30),
      focusedErrorBorder:getOutLineBorder(width: 1.5,color:ProjectColors.bgError,radius:30),
    );
  }




 static InputDecoration getInputDecorationUnderLineDay({String hint,String label,Widget icon}){

    icon ??= Icon(Icons.person,color: ProjectColors.bgIconDay,);
    return InputDecoration(

      suffixIcon: IconButton(onPressed: (){},icon:icon,),
      alignLabelWithHint: true,
      hintText: hint ?? '',
      labelText: label ?? '',
      hintStyle: getTextSyle(size: 14,color: ProjectColors.bgIconDay),
      labelStyle: getTextSyle(size: 14,color: ProjectColors.bgIconDay),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.bgIconDay),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color:  ProjectColors.bgIconDay),
      ),
      errorBorder:UnderlineInputBorder(
        borderSide: BorderSide(color:  ProjectColors.bgIconDay),
      ),
      focusedErrorBorder:UnderlineInputBorder(
        borderSide: BorderSide(color:  ProjectColors.bgIconDay),
      ),
    );
  }


 static InputDecoration getInputDecorationUnderLineDark({String hint,String label,Widget icon}){

    icon ??= Icon(Icons.person,color: ProjectColors.bgIconDark,);
    return InputDecoration(

      suffixIcon: IconButton(onPressed: (){},icon:icon,),
      alignLabelWithHint: true,
      hintText: hint ?? '',
      labelText: label ?? '',
      hintStyle: getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
      labelStyle:getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),


      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.bgIconDark),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color:  ProjectColors.bgIconDark),
      ),
      errorBorder:UnderlineInputBorder(
        borderSide: BorderSide(color:  ProjectColors.bgIconDark),
      ),
      focusedErrorBorder:UnderlineInputBorder(
        borderSide: BorderSide(color:  ProjectColors.bgIconDark),
      ),
    );
  }



 static  TextStyle getTextSyle({double size,Color color,FontWeight fontWeight,bool underLine,bool day=true}){
    underLine ??= false;


    if(day) {
      color=ProjectColors.bgIconDay;
    } else {
      color=ProjectColors.bgIconDark;
    }

    return TextStyle(
        fontSize: size,

        fontWeight: fontWeight?? FontWeight.normal,
        color: color,
        decoration: underLine?TextDecoration.underline:TextDecoration.none
    );
  }



}


