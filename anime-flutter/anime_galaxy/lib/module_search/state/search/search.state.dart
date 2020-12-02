
import 'package:anime_galaxy/module_search/model/search_model/search_model.dart';

class SearchState{}

class SearchStateInit extends SearchState{}

class SearchStateFetching  extends SearchState{}

class SearchStateFetchingSuccess extends SearchState{
  final List<SearchModel> data;

  SearchStateFetchingSuccess(this.data);

}

class SearchStateFetchingError extends SearchState{}