
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_home/service/home/home.service.dart';
import 'package:anime_galaxy/module_home/state/home/home.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class HomeStateManager{
  final HomeService _homeService;
  final PublishSubject<HomeState> _stateSubject = PublishSubject();
  Stream<HomeState> get stateStream => _stateSubject.stream;


  HomeStateManager(this._homeService);

  void getHomeDetails(){
    this._stateSubject.add(HomeStateFetching());

    this._homeService.getHomePageDetails().then((value) {
      if(value != null){
        this._stateSubject.add(HomeStateFetchingSuccess(value));
      }
      else{
        this._stateSubject.add(HomeStateFetchingError());
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
      }
    });
  }
}