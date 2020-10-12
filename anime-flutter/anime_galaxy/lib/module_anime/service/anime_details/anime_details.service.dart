
import 'package:anime_galaxy/module_anime/manager/anime_details/anime_details.manager.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:inject/inject.dart';

@provide
class AnimeDetailsService{
  final AnimeDetailsManager _detailsManager;

  AnimeDetailsService(this._detailsManager);

  Future<AnimeModel> getAnimeDetails(int animeId) async{
    return await _detailsManager.getAnimeDetails(animeId);
  }
}