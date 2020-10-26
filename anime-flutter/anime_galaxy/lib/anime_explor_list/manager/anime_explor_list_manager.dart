

import 'package:anime_galaxy/anime_explor_list/anime_explor_list_repository/anime_explor_list_repository.dart';
import 'package:anime_galaxy/anime_explor_list/model/AllAnimeData.dart';
import 'package:inject/inject.dart';

@provide
class AnimeExplorListManager{

  AnimeExplorListRepository _repository;

  AnimeExplorListManager(this._repository);

  Future<List<AllAnimeData>> getAllAnime() async {
    return this._repository.getAllSeries();
  }
}