import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_auth/state_manager/forgot_password_state_manager/auth_state_manager.dart';
import 'package:anime_galaxy/module_profile/model/profile_model/profile_model.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ForgotPasswordScreen extends StatefulWidget {
  final ForgotPasswordStateManager manager;

  const ForgotPasswordScreen(
      this.manager
      ) ;

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _forgotPasswordFormKey = new GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _passwordSent = false;

  @override
  Widget build(BuildContext context) {
    return _passwordSent
        ?_passwordSentSuccessfully()
        :_screenUi();
  }

  Widget _screenUi(){
    return Scaffold(
      body: Form(
        key:_forgotPasswordFormKey,
        child:  Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
          children :[
            Container(),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Container()
                : CircleAvatar(
              radius: 65.0,
              backgroundImage: AssetImage(
                'assets/images/logo.jpg',
              ),

            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    'سنقوم بإرسال رسالة تعيين لكلمة المرور إلى بريدك الإلكتروني',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'account@email.com',
                labelText: S.of(context).email,
              ),
              validator: (result) {
                if (result.isEmpty) {
                  return 'الرجاء ادخال الإيميل الخاص بك';
                }
                return null;
              },
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              height: 55,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                //TODO : change this to theme service
                color: ProjectColors.ThemeColor,
                onPressed: ()async {
                  if (_forgotPasswordFormKey.currentState.validate()) {
                    try {
                      await widget.manager.resetPassword(_emailController.text.trim());
                      setState(() {
                        _passwordSent = true;
                      });
                    } catch (e) {
                      print(e);
                    }

                  }


                },
                child: Text(
                  'إرسال',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
  Widget _passwordSentSuccessfully(){
    return Scaffold(
      body: Form(
        key:_forgotPasswordFormKey,
        child:  Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children :[
              Container(),
              MediaQuery.of(context).viewInsets.bottom != 0
                  ? Container()
                  : CircleAvatar(
                radius: 65.0,
                backgroundImage: AssetImage(
                  'assets/images/logo.jpg',
                ),

              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'تم إرسال رسالة تعيين لكلمة المرور إلى بريدك الإلكتروني الرجاء قم بتفقده وقم بإعادة تعيين كلمة المرور',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: 200,
                margin: EdgeInsets.only(top: 20),
                height: 55,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),

                  color: ProjectColors.ThemeColor,
                  onPressed: () {

                   Navigator.pop(context);

                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
