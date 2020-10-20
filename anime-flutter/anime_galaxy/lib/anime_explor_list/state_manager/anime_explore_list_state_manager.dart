




import 'package:anime_galaxy/anime_explor_list/services/anime_explor_list_services.dart';
import 'package:anime_galaxy/anime_explor_list/state/anime_explore_list_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AnimeExplorListStateManager{

final AnimeExplorListServices _services;

AnimeExplorListStateManager(this._services);



final PublishSubject<AnimeExplorListState> _stateSubject = PublishSubject();
Stream<AnimeExplorListState> get stateStream => _stateSubject.stream;


void getShows( ) {
  _stateSubject.add(AnimeExplorListStateFetching());

  _services.getAllAnime( ).then((result) {
    if (result == null) {
      _stateSubject.add(AnimeExplorListStateFetchingError());
      Fluttertoast.showToast(msg: 'Error Fetching data');
    } else {
      _stateSubject.add(AnimeExplorListStateFetchingSuccess(result));
    }
  });
}
}