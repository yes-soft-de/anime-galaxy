// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enable Audio:`
  String get enableAudio {
    return Intl.message(
      'Enable Audio:',
      name: 'enableAudio',
      desc: '',
      args: [],
    );
  }

  /// `No camera found`
  String get noCameraFound {
    return Intl.message(
      'No camera found',
      name: 'noCameraFound',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Items!`
  String get errorLoadingItems {
    return Intl.message(
      'Error Loading Items!',
      name: 'errorLoadingItems',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Games List`
  String get gamesList {
    return Intl.message(
      'Games List',
      name: 'gamesList',
      desc: '',
      args: [],
    );
  }

  /// `Request a Swap!`
  String get requestASwap {
    return Intl.message(
      'Request a Swap!',
      name: 'requestASwap',
      desc: '',
      args: [],
    );
  }

  /// `Error Getting Swap Item id!`
  String get errorGettingSwapItemId {
    return Intl.message(
      'Error Getting Swap Item id!',
      name: 'errorGettingSwapItemId',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Data`
  String get errorLoadingData {
    return Intl.message(
      'Error Loading Data',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }

  /// `Empty List`
  String get emptyList {
    return Intl.message(
      'Empty List',
      name: 'emptyList',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Input Phone Number`
  String get pleaseInputPhoneNumber {
    return Intl.message(
      'Please Input Phone Number',
      name: 'pleaseInputPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Loading!`
  String get loading {
    return Intl.message(
      'Loading!',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Send me a Code!`
  String get sendMeACode {
    return Intl.message(
      'Send me a Code!',
      name: 'sendMeACode',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get saudiArabia {
    return Intl.message(
      'Saudi Arabia',
      name: 'saudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `USA`
  String get usa {
    return Intl.message(
      'USA',
      name: 'usa',
      desc: '',
      args: [],
    );
  }

  /// `Lebanon`
  String get lebanon {
    return Intl.message(
      'Lebanon',
      name: 'lebanon',
      desc: '',
      args: [],
    );
  }

  /// `Syria`
  String get syria {
    return Intl.message(
      'Syria',
      name: 'syria',
      desc: '',
      args: [],
    );
  }

  /// `Chat Room`
  String get chatRoom {
    return Intl.message(
      'Chat Room',
      name: 'chatRoom',
      desc: '',
      args: [],
    );
  }

  /// `Start Writing`
  String get startWriting {
    return Intl.message(
      'Start Writing',
      name: 'startWriting',
      desc: '',
      args: [],
    );
  }

  /// `Be the First to Comment`
  String get beTheFirstToComment {
    return Intl.message(
      'Be the First to Comment',
      name: 'beTheFirstToComment',
      desc: '',
      args: [],
    );
  }

  /// `Search a Game :)`
  String get searchAGame {
    return Intl.message(
      'Search a Game :)',
      name: 'searchAGame',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `to my collection`
  String get toMyCollection {
    return Intl.message(
      'to my collection',
      name: 'toMyCollection',
      desc: '',
      args: [],
    );
  }

  /// `Please Upload the Image`
  String get pleaseUploadTheImage {
    return Intl.message(
      'Please Upload the Image',
      name: 'pleaseUploadTheImage',
      desc: '',
      args: [],
    );
  }

  /// `Submit Game!`
  String get submitGame {
    return Intl.message(
      'Submit Game!',
      name: 'submitGame',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImage {
    return Intl.message(
      'Upload Image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Empty Tag List`
  String get emptyTagList {
    return Intl.message(
      'Empty Tag List',
      name: 'emptyTagList',
      desc: '',
      args: [],
    );
  }

  /// `Insert via a Preset`
  String get insertViaAPreset {
    return Intl.message(
      'Insert via a Preset',
      name: 'insertViaAPreset',
      desc: '',
      args: [],
    );
  }

  /// `Insert via Camera`
  String get insertViaCamera {
    return Intl.message(
      'Insert via Camera',
      name: 'insertViaCamera',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Feedback!`
  String get feedback {
    return Intl.message(
      'Feedback!',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Feed`
  String get feed {
    return Intl.message(
      'Feed',
      name: 'feed',
      desc: '',
      args: [],
    );
  }

  /// `TOS`
  String get tos {
    return Intl.message(
      'TOS',
      name: 'tos',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Set Exchange Game`
  String get setExchangeGame {
    return Intl.message(
      'Set Exchange Game',
      name: 'setExchangeGame',
      desc: '',
      args: [],
    );
  }

  /// `Start Chat`
  String get startChat {
    return Intl.message(
      'Start Chat',
      name: 'startChat',
      desc: '',
      args: [],
    );
  }

  /// `Set Game`
  String get setGame {
    return Intl.message(
      'Set Game',
      name: 'setGame',
      desc: '',
      args: [],
    );
  }

  /// `Username:`
  String get username {
    return Intl.message(
      'Username:',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message(
      'Sign out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Not Logged in!`
  String get notLoggedIn {
    return Intl.message(
      'Not Logged in!',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Empty Comment!`
  String get emptyComment {
    return Intl.message(
      'Empty Comment!',
      name: 'emptyComment',
      desc: '',
      args: [],
    );
  }

  /// `Save Profile`
  String get saveProfile {
    return Intl.message(
      'Save Profile',
      name: 'saveProfile',
      desc: '',
      args: [],
    );
  }

  /// `Saving!`
  String get saving {
    return Intl.message(
      'Saving!',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide a short story about you :)`
  String get pleaseProvideAShortStoryAboutYou {
    return Intl.message(
      'Please Provide a short story about you :)',
      name: 'pleaseProvideAShortStoryAboutYou',
      desc: '',
      args: [],
    );
  }

  /// `Please Provide your Name :)`
  String get pleaseProvideYourName {
    return Intl.message(
      'Please Provide your Name :)',
      name: 'pleaseProvideYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please Upload your Image :)`
  String get pleaseUploadYourImage {
    return Intl.message(
      'Please Upload your Image :)',
      name: 'pleaseUploadYourImage',
      desc: '',
      args: [],
    );
  }

  /// `Uploading`
  String get uploading {
    return Intl.message(
      'Uploading',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `This Game is Great`
  String get thisGameIsGreat {
    return Intl.message(
      'This Game is Great',
      name: 'thisGameIsGreat',
      desc: '',
      args: [],
    );
  }

  /// `برونزي`
  String get pronze {
    return Intl.message(
      'برونزي',
      name: 'pronze',
      desc: '',
      args: [],
    );
  }

  /// `فضي`
  String get silver {
    return Intl.message(
      'فضي',
      name: 'silver',
      desc: '',
      args: [],
    );
  }

  /// `Anime`
  String get anime {
    return Intl.message(
      'Anime',
      name: 'anime',
      desc: '',
      args: [],
    );
  }

  /// `قيم المسلسل`
  String get EvaluteSerise {
    return Intl.message(
      'قيم المسلسل',
      name: 'EvaluteSerise',
      desc: '',
      args: [],
    );
  }

  /// `حول`
  String get about {
    return Intl.message(
      'حول',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Confirm!`
  String get confirm {
    return Intl.message(
      'Confirm!',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `قيم المسلسل`
  String get RateSeries {
    return Intl.message(
      'قيم المسلسل',
      name: 'RateSeries',
      desc: '',
      args: [],
    );
  }

  /// `حول`
  String get About {
    return Intl.message(
      'حول',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `المزيد`
  String get More {
    return Intl.message(
      'المزيد',
      name: 'More',
      desc: '',
      args: [],
    );
  }

  /// `التصنيف`
  String get Classification {
    return Intl.message(
      'التصنيف',
      name: 'Classification',
      desc: '',
      args: [],
    );
  }

  /// `آخر الحلقات`
  String get LastEpisodes {
    return Intl.message(
      'آخر الحلقات',
      name: 'LastEpisodes',
      desc: '',
      args: [],
    );
  }

  /// `آخر الردود والتعليقات`
  String get LastReplaysAndComments {
    return Intl.message(
      'آخر الردود والتعليقات',
      name: 'LastReplaysAndComments',
      desc: '',
      args: [],
    );
  }

  /// `مشاركة`
  String get Share {
    return Intl.message(
      'مشاركة',
      name: 'Share',
      desc: '',
      args: [],
    );
  }

  /// `أحببته`
  String get Like {
    return Intl.message(
      'أحببته',
      name: 'Like',
      desc: '',
      args: [],
    );
  }

  /// `متابعة`
  String get Follow {
    return Intl.message(
      'متابعة',
      name: 'Follow',
      desc: '',
      args: [],
    );
  }

  /// `حلقة`
  String get Episode {
    return Intl.message(
      'حلقة',
      name: 'Episode',
      desc: '',
      args: [],
    );
  }

  /// `الموسم`
  String get Season {
    return Intl.message(
      'الموسم',
      name: 'Season',
      desc: '',
      args: [],
    );
  }

  /// `حلقات جديدة`
  String get newEpisodes {
    return Intl.message(
      'حلقات جديدة',
      name: 'newEpisodes',
      desc: '',
      args: [],
    );
  }

  /// `مسلسلات متابعة`
  String get watchedSeries {
    return Intl.message(
      'مسلسلات متابعة',
      name: 'watchedSeries',
      desc: '',
      args: [],
    );
  }

  /// `مسلسلات قد تعجبك`
  String get mayLikeSeries {
    return Intl.message(
      'مسلسلات قد تعجبك',
      name: 'mayLikeSeries',
      desc: '',
      args: [],
    );
  }

  /// `ذهبي`
  String get gold {
    return Intl.message(
      'ذهبي',
      name: 'gold',
      desc: '',
      args: [],
    );
  }

  /// `نقطة`
  String get point {
    return Intl.message(
      'نقطة',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `عضو`
  String get member {
    return Intl.message(
      'عضو',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `ابدأ متابعة المسلسلات`
  String get startWachingSeries {
    return Intl.message(
      'ابدأ متابعة المسلسلات',
      name: 'startWachingSeries',
      desc: '',
      args: [],
    );
  }

  /// `ddd`
  String get test {
    return Intl.message(
      'ddd',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `إحصاءات`
  String get statics {
    return Intl.message(
      'إحصاءات',
      name: 'statics',
      desc: '',
      args: [],
    );
  }

  /// `التقييم العام`
  String get generalEvaluation {
    return Intl.message(
      'التقييم العام',
      name: 'generalEvaluation',
      desc: '',
      args: [],
    );
  }

  /// `التعليقات الشهرية`
  String get monthlyComments {
    return Intl.message(
      'التعليقات الشهرية',
      name: 'monthlyComments',
      desc: '',
      args: [],
    );
  }

  /// `تفاعل جديد`
  String get newInteraction {
    return Intl.message(
      'تفاعل جديد',
      name: 'newInteraction',
      desc: '',
      args: [],
    );
  }

  /// `إرسال التعليق`
  String get sendComment {
    return Intl.message(
      'إرسال التعليق',
      name: 'sendComment',
      desc: '',
      args: [],
    );
  }

  /// `اضف تعليقك`
  String get addYourComment {
    return Intl.message(
      'اضف تعليقك',
      name: 'addYourComment',
      desc: '',
      args: [],
    );
  }

  /// `يحوي حرق`
  String get spoilerAlert {
    return Intl.message(
      'يحوي حرق',
      name: 'spoilerAlert',
      desc: '',
      args: [],
    );
  }

  /// `هناك مشكلة ما أعد التعليق لاحقا`
  String get ommentingError {
    return Intl.message(
      'هناك مشكلة ما أعد التعليق لاحقا',
      name: 'ommentingError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}