import 'package:anime_galaxy/module_search/repository/search_repository/search.repository.dart';
import 'package:anime_galaxy/module_search/response/search_response/search_reaponse.dart';
import 'package:inject/inject.dart';

@provide
class SearchManager{
  final SearchRepository _searchRepository;

  SearchManager(this._searchRepository);

  Future<List<SearchResponse>> searchAnime(String animeName)async{

    return await _searchRepository.searchAnime(animeName);
  }
}