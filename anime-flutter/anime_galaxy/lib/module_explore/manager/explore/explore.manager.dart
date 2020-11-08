
import 'package:anime_galaxy/module_explore/repository/explore/explore.repositry.dart';
import 'package:anime_galaxy/module_explore/response/expolre_response/explore_response.dart';
import 'package:inject/inject.dart';

@provide
class ExploreManager {
  final ExploreRepository _exploreRepository;
  ExploreManager(this._exploreRepository);

  Future<ExploreResponse> getExploreScreenContent()async{
    return await _exploreRepository.getExploreScreenContent();
  }
}