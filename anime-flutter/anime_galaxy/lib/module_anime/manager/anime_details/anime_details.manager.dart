
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/repository/anime_details/anime_details.repository.dart';
import 'package:inject/inject.dart';

@provide
class AnimeDetailsManager{
  final AnimeDetailsRepository _animeDetailsRepository;
  AnimeDetailsManager(this._animeDetailsRepository);

  Future<AnimeModel> getAnimeDetails(animeId)async{
    return await _animeDetailsRepository.getAnimeDetails(animeId);
  }
}