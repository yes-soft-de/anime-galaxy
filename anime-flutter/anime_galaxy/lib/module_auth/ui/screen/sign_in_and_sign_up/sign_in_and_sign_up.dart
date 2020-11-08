
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_auth/request/login/login_request.dart';
import 'package:anime_galaxy/module_auth/request/register/registerRequest.dart';
import 'package:anime_galaxy/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:anime_galaxy/module_auth/states/auth_states/auth_states.dart';
import 'package:anime_galaxy/module_auth/style/style_auth.dart';
import 'package:anime_galaxy/module_auth/ui/widget/custome_button/custome_button.dart';
import 'package:anime_galaxy/module_auth/ui/widget/social_icon/social_icon.dart';
import 'package:anime_galaxy/module_init_account/init_account_routes.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';



@provide
class LoginRegisterScreen extends StatefulWidget {
  final  AuthStateManager _stateManager;

  final StyleAuth styleApp = new StyleAuth();


  LoginRegisterScreen(this._stateManager);

  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool loginScreen = true;
  bool loading = false;
  AuthState currentState =  AuthStateInit();
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _registerUsernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });

  }

  void processEvent(){
    print(currentState.runtimeType);
   if(currentState is LoginStateSuccess){
     loading = false;
     Navigator.pushNamed(context,MainScreenRoute.MAIN_SCREEN_ROUTE);
   }
   if(currentState is RegisterStateSuccess){

     loading = false;
     Navigator.pushNamed(context,InitAccountRoutes.INIT_ACCOUNT_ROUTE);
   }
  }


  String _validateField(String value) {
    if (value.isEmpty) {
      return 'هذا الحقل لا يمكن أن يكون فارغ';
    } else {
      return null;
    }
  }

  void login() {
    if (_formKey.currentState.validate()) {
      loading = true;
      widget._stateManager.login(
         LoginRequest(
          userId:  _loginEmailController.text.trim(),
          password: _loginPasswordController.text.trim()
        )
         );
    }
  }

  void register() {
    if (_registerFormKey.currentState.validate()) {
      loading = true;
      widget._stateManager.register(
          RegisterRequest(
              userId:  _registerEmailController.text.trim(),
              password: _registerPasswordController.text.trim(),
            userName: _registerUsernameController.text.trim()
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   return loginScreen ?
            loginUI():
            registerUI();

  }

  Widget loginUI(){
    return SafeArea(
      child:Scaffold(
        backgroundColor: ProjectColors.bgSignUpDark,
        appBar: AppBar(
          backgroundColor:  ProjectColors.bgSignUpDark,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidate: _autoValidate ,
            key: _formKey,
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
                          child: Image.asset('assets/images/logo_dark.png'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: _loginEmailController,
                    style: StyleAuth.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                    decoration: StyleAuth.getInputDecorationUnderLineDark(
                        label: 'البريد الالكتروني',
                        icon: Icon(Icons.email)
                    ),
                    keyboardType: TextInputType.text,
                    validator: (username) => _validateField(username),
                  ),



                  TextFormField(
                    controller: _loginPasswordController,
                    obscureText: true,
                    style: StyleAuth.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                    decoration: StyleAuth.getInputDecorationUnderLineDark(
                        label: 'كلمة مرور',
                        icon: Icon(Icons.work,color: ProjectColors.bgIconDark,)
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (password) => _validateField(password),
                  ),



                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalIcon(
                        day: false,
                        iconSrc: 'assets/images/facebook.svg',
                        press: () {},
                      ),
                      SocalIcon(
                        day: false,
                        iconSrc: 'assets/images/twitter.svg',
                        press: () {},
                      ),
                      SocalIcon(
                        day: false,
                        iconSrc: 'assets/images/google-plus.svg',
                        press: () {},
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    loginScreen = false;
                    setState(() {

                    });
                  },
                  child: Text(
                    'لا أملك حسابا',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),

                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar:

        SizedBox(
          height: 50,
          child: CustomeButton(
            txt: 'تسجيل الدخول',
            textStyle: StyleAuth.getTextSyle(day: false,size: 14,),
            press:()=> loading ? null: login(),


          ),
        ),
      ) ,
    );
  }

  Widget registerUI(){
    return  SafeArea(
        child:Scaffold(
          backgroundColor: ProjectColors.bgSignUpDark,
          appBar: AppBar(
            backgroundColor:  ProjectColors.bgSignUpDark,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              autovalidate: _autoValidate,
              key: _registerFormKey,
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
                            child: Image.asset('assets/images/logo_dark.png'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      controller: _registerUsernameController,
                      style: StyleAuth.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                      decoration: StyleAuth.getInputDecorationUnderLineDark(
                          label: S.of(context).name,
                          hint:  S.of(context).name),
                      keyboardType: TextInputType.text,
                      validator: (userName)=>_validateField(userName),
                    ),

                    TextFormField(
                      controller: _registerEmailController,
                      style: StyleAuth.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                      decoration: StyleAuth.getInputDecorationUnderLineDark(
                          label: S.of(context).email,
                          hint: S.of(context).email,icon: Icon(Icons.email,color: ProjectColors.bgIconDark,)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (email)=>_validateField(email),
                    ),

                    TextFormField(
                      controller: _registerPasswordController,
                      obscureText: true,
                      style: StyleAuth.getTextSyle(size: 14,color:ProjectColors.bgIconDark ,day: false),
                      decoration: StyleAuth.getInputDecorationUnderLineDark(
                          label: S.of(context).password,
                          hint: S.of(context).password,icon: Icon(Icons.work,color: ProjectColors.bgIconDark,)),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (password)=>_validateField(password),
                    ),



                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocalIcon(
                          day: false,
                          iconSrc: 'assets/images/facebook.svg',
                          press: () {},
                        ),
                        SocalIcon(
                          day: false,
                          iconSrc: 'assets/images/twitter.svg',
                          press: () {},
                        ),
                        SocalIcon(
                          day: false,
                          iconSrc: 'assets/images/google-plus.svg',
                          press: () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        loginScreen = true;
                        setState(() {

                        });
                      },
                      child: Text(
                        'أملك حسابا',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar:

          SizedBox(
            height: 50,
            child: CustomeButton(
              txt: 'تسجيل الحساب',
              textStyle: StyleAuth.getTextSyle(day: false,size: 14,),
              press: (){
              register();
              },

            ),
          ),

        ) ,
      );

  }
}
