

import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_explore/response/comming_soon_response/comming_soon_response.dart';
import 'package:anime_galaxy/module_explore/service/category_animes/category_animes.service.dart';
import 'package:anime_galaxy/module_explore/state/category_animes/category_animes.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class CategoryAnimesStateManager{
  final CategoryAnimesService _categoryAnimesService;
  final PublishSubject<CategoryAnimesState> _stateSubject = PublishSubject();
  Stream<CategoryAnimesState> get stateStream  => _stateSubject.stream;

  CategoryAnimesStateManager(this._categoryAnimesService);

  void getCategorySeries(int categoryId,String categoryName){
    _stateSubject.add(CategoryAnimesStateFetching());

    _categoryAnimesService.getCategorySeries(categoryId, categoryName).then((value) {
      if(value == null){
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
        _stateSubject.add(CategoryAnimesStateFetchingError());
      }else{
        _stateSubject.add(CategoryAnimesStateFetchingSuccess(value));
      }
    });
  }
}