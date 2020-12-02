
import 'package:anime_galaxy/module_explore/repository/category_animes/category_animes.repository.dart';
import 'package:anime_galaxy/module_explore/response/series_response/series_response.dart';
import 'package:inject/inject.dart';

@provide
class CategoryAnimesManager{
  final CategoryAnimesRepository _categoryAnimesRepository;

  CategoryAnimesManager(this._categoryAnimesRepository);

  Future<List<SeriesResponse>> getCategorySeries(int categoryId)async{
    return await _categoryAnimesRepository.getCategorySeries(categoryId);
  }

}