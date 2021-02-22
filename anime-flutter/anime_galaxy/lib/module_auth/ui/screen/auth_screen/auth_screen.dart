import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/main_screen/main_screen_routes.dart';
import 'package:anime_galaxy/module_auth/auth_routes.dart';
import 'package:anime_galaxy/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:anime_galaxy/module_auth/states/auth_states/auth_states.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';

@provide
class AuthScreen extends StatefulWidget {
  final AuthStateManager manager;

  AuthScreen(this.manager);

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthState _currentState;
  

  bool loginMode = false;

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;
  String redirectTo;

  @override
  void initState() {
    super.initState();
    widget.manager.status.listen((event) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(event??''),
            backgroundColor: Colors.grey,
          ),
      );
    });
    widget.manager.stateStream.listen((event) {
      print(event.runtimeType.toString());
      _currentState = event;
      loading = false;
      processEvent();
    });
  }

  void processEvent(){
    if (_currentState is AuthStateSuccess) {
      redirectTo = MainScreenRoute.MAIN_SCREEN_ROUTE;
    }
    if (_currentState is AuthStateNotRegisteredUser) {
      redirectTo = ProfileRoutes.ROUTE_EDIT_PROFILE;
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {


    widget.manager.isSignedIn().then((value) {
      if (value) Navigator.of(context).pushReplacementNamed(redirectTo);
    });

    if (_currentState is AuthStateError) {
      AuthStateError errorState = _currentState;
      if (errorState.errorMsg != null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(errorState.errorMsg),
      ));
    }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: _getUI(),
    );
  }

  Widget _getUI() {
    return loginMode ? getLoginPage() : getRegisterPage();
  }

  Widget getRegisterPage() {
    return Scaffold(
      body: Form(
        key: _signUpFormKey,
        autovalidateMode: AutovalidateMode.always,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Container()
                : CircleAvatar(
              radius: 65.0,
              backgroundImage: AssetImage(
                'assets/images/logo.jpg',
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
//                  TextFormField(
//                    controller: _nameController,
//                    decoration: InputDecoration(
//                        icon: Icon(Icons.person),
//                        hintText: S.of(context).yourName,
//                        labelText: S.of(context).name),
//                    validator: (result) {
//                      if (result.isEmpty) {
//                        return S.of(context).pleaseProvideYourName;
//                      }
//                      return null;
//                    },
//                  ),
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
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: '******',
                      labelText: S.of(context).password,
                    ),
                    validator: (result) {
                      if (result.length <8) {
                        return 'كلمة المرور يجب ان تكون من 8 محارف على الأقل';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? SwapThemeDataService.getDarkBGColor()
                                    : Colors.white,
                            width: .25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/images/google-plus.svg',
                          height: 32,
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.manager.authWithGoogle();
                    },
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: GestureDetector(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        border: Border.all(
//                            color:
//                                Theme.of(context).brightness == Brightness.light
//                                    ? SwapThemeDataService.getDarkBGColor()
//                                    : Colors.white,
//                            width: .25),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: SvgPicture.asset(
//                          'assets/images/twitter.svg',
//                          height: 32,
//                        ),
//                      ),
//                    ),
//                    onTap: () {},
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: GestureDetector(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        border: Border.all(
//                            color:
//                                Theme.of(context).brightness == Brightness.light
//                                    ? SwapThemeDataService.getDarkBGColor()
//                                    : Colors.white,
//                            width: .25),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: SvgPicture.asset(
//                          'assets/images/facebook.svg',
//                          height: 32,
//                        ),
//                      ),
//                    ),
//                    onTap: () {},
//                  ),
//                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                loginMode = true;
                setState(() {});
              },
              child: Text(loading
                  ? S.of(context).loading
                  : S.of(context).iHaveAnAccount),
            ),
            GestureDetector(
              onTap: () {
               if (_signUpFormKey.currentState.validate()) {
                 if (!loading) {
                   loading = true;
                   setState(() {});
                   widget.manager.registerWithEmailAndPassword(
                     _emailController.text.trim(),
                     _passwordController.text.trim(),
                     _nameController.text.trim(),
                   );
                 }
              }

              },
              child: Container(
                color: ProjectColors.ThemeColor,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loading
                          ? S.of(context).loading
                          : S.of(context).registerNewAccount,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLoginPage() {
    return Scaffold(
      body: Form(
        key: _signInFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            MediaQuery.of(context).viewInsets.bottom != 0
                ? Container()
                : CircleAvatar(
              radius: 65.0,
              backgroundImage: AssetImage(
                'assets/images/logo.jpg',
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
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
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: '******',
                      labelText: S.of(context).password,
                    ),
                    validator: (result) {
                      if (result.length <8) {
                        return 'كلمة المرور يجب ان تكون من 8 محارف على الأقل';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                ],
              ),
            ),

            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? SwapThemeDataService.getDarkBGColor()
                                    : Colors.white,
                            width: .25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/images/google-plus.svg',
                          height: 32,
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.manager.authWithGoogle();
                    },
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: GestureDetector(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        border: Border.all(
//                            color:
//                                Theme.of(context).brightness == Brightness.light
//                                    ? SwapThemeDataService.getDarkBGColor()
//                                    : Colors.white,
//                            width: .25),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: SvgPicture.asset(
//                          'assets/images/twitter.svg',
//                          height: 32,
//                        ),
//                      ),
//                    ),
//                    onTap: () {
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text('Social App Id not provided'),
//                      ));
//                    },
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: GestureDetector(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        border: Border.all(
//                            color:
//                                Theme.of(context).brightness == Brightness.light
//                                    ? SwapThemeDataService.getDarkBGColor()
//                                    : Colors.white,
//                            width: .25),
//                      ),
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: SvgPicture.asset(
//                          'assets/images/facebook.svg',
//                          height: 32,
//                        ),
//                      ),
//                    ),
//                    onTap: () {
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text('Social App Id not provided'),
//                      ));
//                    },
//                  ),
//                ),
              ],
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, AuthRoutes.FORGOT_PASSWORD_SCREEN);
              },
              child: Center(
                child: Text(
                    'نسيت كلمة المرور'
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                loginMode = false;
                setState(() {});
              },
              child: Text(loading
                  ? S.of(context).loading
                  : S.of(context).createNewAccount),
            ),
            GestureDetector(
              onTap: () {
                if(_signInFormKey.currentState.validate()){
                  if (!loading) {
                    loading = true;
                    widget.manager.signWithEmailAndPassword(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  }
                }

              },
              child: Container(
                color: ProjectColors.ThemeColor,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loading ? S.of(context).loading : S.of(context).login,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
