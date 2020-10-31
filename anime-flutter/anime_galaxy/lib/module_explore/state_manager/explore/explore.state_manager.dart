

import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_explore/service/explore/explore.service.dart';
import 'package:anime_galaxy/module_explore/state/explore/explore.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class ExploreStateManager {
  final ExploreService _exploreService;
  final PublishSubject<ExploreState> _stateSubject = PublishSubject();
  Stream<ExploreState> get stateStream => _stateSubject.stream;

  ExploreStateManager(this._exploreService);

  void getExploreScreenContent(){
    _stateSubject.add(ExploreStateFetching());
    _exploreService.getExploreScreenContent().then((value) {
      if(value == null){
        _stateSubject.add(ExploreStateFetchingError());
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
      }else{
        _stateSubject.add(ExploreStateFetchingSuccess(value));
      }
    });
  }


}