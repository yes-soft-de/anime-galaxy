import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_init_account/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_init_account/service/init_account/init_account.service.dart';
import 'package:anime_galaxy/module_init_account/state/init_account/init_account.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final PublishSubject<InitAccountState> _stateSubject = PublishSubject();

  Stream<InitAccountState> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._initAccountService,
  );

  void getCategories() {
    _stateSubject.add(InitAccountStateFetching());
    _initAccountService.getCategories().then((value) {
      if (value != null) {
        _stateSubject.add(InitAccountStateSuccess(value));
      } else {
        _stateSubject.add(InitAccountStateError());
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
      }
    });
  }

  void addAnimesToWatch(List<FavouriteRequest> favouriteRequests) {
    _initAccountService.addAnimesToWatch(favouriteRequests).then((value) {
      if (value == null) {
        
        _stateSubject.add(InitAccountStateAddFavouritesError());
      } else {
        _stateSubject.add(InitAccountStateAddFavouritesSuccess());
      }
    });
  }
}
