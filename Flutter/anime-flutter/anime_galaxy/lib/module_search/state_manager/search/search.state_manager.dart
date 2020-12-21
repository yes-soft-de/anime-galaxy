
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_search/service/search_service/search.service.dart';
import 'package:anime_galaxy/module_search/state/search/search.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class SearchStateManager {
  final SearchService _searchService;
  PublishSubject<SearchState> _stateSubject = PublishSubject();
  Stream<SearchState> get stateStream => _stateSubject.stream;

  SearchStateManager(this._searchService);

  void searchAnime(String animeName){
    _stateSubject.add(SearchStateFetching());

    _searchService.seachAnime(animeName).then((value) {
      if(value == null){
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
        _stateSubject.add(SearchStateFetchingError());
      }else{
        _stateSubject.add(SearchStateFetchingSuccess(value));
      }
    });
  }
}