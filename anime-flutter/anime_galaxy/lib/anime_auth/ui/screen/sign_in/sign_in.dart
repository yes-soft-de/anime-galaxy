



import 'package:anime_galaxy/anime_auth/style_auth.dart';
import 'package:anime_galaxy/anime_auth/ui/widget/custome_button/custome_button.dart';
import 'package:anime_galaxy/anime_auth/ui/widget/social_icon/social_icon.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';



@provide
class SignIn extends StatefulWidget {


  final StyleAuth styleApp;


  SignIn(this.styleApp);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        backgroundColor: ProjectColors.bgSignUpDark,
        appBar: AppBar(
          backgroundColor:  ProjectColors.bgSignUpDark,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        child: Image.asset("assets/images/logo_dark.png"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),

                TextFormField(

                  style: widget.styleApp.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                  decoration: widget.styleApp.getInputDecorationUnderLineDark(
                      label: "الاسم"),
                ),



                TextFormField(
                  style: widget.styleApp.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                  decoration: widget.styleApp.getInputDecorationUnderLineDark(label: "كلمة مرور",icon: Icon(Icons.work,color: ProjectColors.bgIconDark,)),
                ),



                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      day: false,
                      iconSrc: "assets/images/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      day: false,
                      iconSrc: "assets/images/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      day: false,
                      iconSrc: "assets/images/google-plus.svg",
                      press: () {},
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),

        bottomNavigationBar:

        CustomeButton(
          txt: "تابع",
          textStyle: widget.styleApp.getTextSyle(day: false,size: 14,),
          press: (){
            //  Navigator.pushNamed(context, RotingModule.ROUTE_ANIM_SETTIING_PAGE);
          },

        ),
      ) ,
    );
  }
}
