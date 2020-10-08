import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/anime_auth/ui/screen/sign_in/sign_in.dart';
import 'package:anime_galaxy/anime_auth/ui/screen/sign_up/sign_up.dart';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

import 'auth_routes.dart';


@provide
 class AuthModuleAnime extends YesModule{
 final SignUp _signUp;
 final SignIn _signIn;
 AuthModuleAnime(this._signUp,this._signIn);


  @override
  Map<String, WidgetBuilder> getRoutes(){
    return {
     AuthRoutesAnime.ROUTE_Sign_UP : (context)=> _signUp,
     AuthRoutesAnime.ROUTE_Sign_in : (context)=> _signIn,
    };
  }
 }