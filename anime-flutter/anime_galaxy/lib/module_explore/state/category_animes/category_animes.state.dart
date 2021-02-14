 
import 'package:anime_galaxy/module_explore/model/category_animes/category_animes.model.dart';

class CategoryAnimesState{}

class CategoryAnimesStateInit extends CategoryAnimesState{}

class CategoryAnimesStateFetching  extends CategoryAnimesState{}

class CategoryAnimesStateFetchingSuccess extends CategoryAnimesState{
  final List<CategoryAnimesModel> data;

  CategoryAnimesStateFetchingSuccess(this.data);

}

class CategoryAnimesStateFetchingError extends CategoryAnimesState{}




