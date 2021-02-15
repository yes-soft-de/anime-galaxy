import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:anime_galaxy/module_auth/enums/auth_source.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_auth/states/auth_states/auth_states.dart';
import 'package:anime_galaxy/module_profile/service/my_profile/my_profile.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@provide
class ForgotPasswordStateManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService;

  ForgotPasswordStateManager(
    this._authService,
  ) ;

  final PublishSubject<AuthState> _stateSubject = PublishSubject();

  Stream<AuthState> get stateStream => _stateSubject.stream;

  Stream<String> get status => _authService.authServiceStateSubject.stream;
  String _verificationId;

  void SignInWithPhone(String phone) {
    _authService.authServiceStateSubject.add('Sending SMS to this number');
    _auth
        .verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted: (credentials) {
              _auth.signInWithCredential(credentials).then((value) async {
                await _authService.loginUser(
                  _auth.currentUser.uid,
                  _auth.currentUser.displayName ?? _auth.currentUser.uid,
                  null,
                  AUTH_SOURCE.PHONE,
                );
                _stateSubject.add(AuthStateSuccess());
              }).catchError((err) {
                _stateSubject.add(AuthStateError(err));
              });
            },
            verificationFailed: (err) {
              Fluttertoast.showToast(msg: err.message);
            },
            codeSent: (String verificationId, int forceResendingToken) {
              verificationId = verificationId;
              _stateSubject.add(AuthStateCodeSent());
            },
            codeAutoRetrievalTimeout: (verificationId) {
              _verificationId = verificationId;
            })
        .catchError((err) {
      _authService.authServiceStateSubject.add(err.toString());
      _stateSubject.add(AuthStateError(err.toString()));
    });
  }

  Future<void> resetPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  }


}
