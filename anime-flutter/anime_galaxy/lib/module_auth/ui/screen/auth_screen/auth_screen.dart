import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:anime_galaxy/module_auth/states/auth_states/auth_states.dart';
import 'package:anime_galaxy/module_profile/profile_routes.dart';
import 'package:anime_galaxy/module_theme/service/theme_service/theme_service.dart';
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
  String _errorMsg;
  AuthState _currentState;
  Scaffold pageLayout;

  bool loginMode = false;

  final GlobalKey _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    String redirectTo = ModalRoute.of(context).settings.arguments.toString();
    redirectTo =
        redirectTo == null ? redirectTo : ProfileRoutes.ROUTE_EDIT_PROFILE;

    widget.manager.isSignedIn().then((value) {
      if (value) Navigator.of(context).pushReplacementNamed(redirectTo);
    });

    widget.manager.stateStream.listen((event) {
      _currentState = event;
      loading = false;
      _getUI();
    });

    if (_currentState is AuthStateSuccess) {
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
    if (_currentState is AuthStateError) {
      AuthStateError errorState = _currentState;
      _errorMsg = errorState.errorMsg;
    }

    return _getUI();
  }

  Widget _getUI() {
    if (_currentState is AuthStateLoading) {
    } else if (loginMode == false) {}

    return getRegisterPage();
  }

  Widget getRegisterPage() {
    return Scaffold(
      body: Form(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Image.asset(
              'assets/images/logo.jpg',
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: S.of(context).yourName,
                        labelText: S.of(context).name),
                    validator: (result) {
                      if (result.isEmpty) {
                        return S.of(context).pleaseProvideYourName;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'account@email.com',
                      labelText: S.of(context).email,
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: '******',
                      labelText: S.of(context).password,
                    ),
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
                          'assets/images/twitter.svg',
                          height: 32,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
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
                          'assets/images/facebook.svg',
                          height: 32,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                loginMode = true;
                setState(() {});
              },
              child: Text(S.of(context).iHaveAnAccount),
            ),
            Container(
              color: Colors.red,
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).registerNewAccount,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
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
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Image.asset(
              'assets/images/logo.jpg',
              height: 120,
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
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: '******',
                      labelText: S.of(context).password,
                    ),
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
                          'assets/images/twitter.svg',
                          height: 32,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
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
                          'assets/images/facebook.svg',
                          height: 32,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                loginMode = false;
                setState(() {});
              },
              child: Text(S.of(context).createNewAccount),
            ),
            Container(
              color: Colors.red,
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).login,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
