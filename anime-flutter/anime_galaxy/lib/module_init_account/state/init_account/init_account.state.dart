

import 'package:anime_galaxy/module_init_account/model/init_account_model.dart';

class InitAccountState{}

class InitAccountStateInit extends InitAccountState{}

class InitAccountStateFetching extends InitAccountState{}

class InitAccountStateSuccess extends InitAccountState{
  List<InitAccountModel> data;

  InitAccountStateSuccess(this.data);
}

class InitAccountStateError extends InitAccountState{}

class InitAccountStateAddFavouritesSuccess extends InitAccountState{}

class InitAccountStateAddFavouritesError extends InitAccountState{}