import 'package:anime_galaxy/abstracts/module/yes_module.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_anime/ui/screen/anime_details_screen/anime_details_screen.dart';
import 'package:inject/inject.dart';

@provide
class AnimeModlue extends YesModule{
  final AnimeDetailsScreen _animeDetailsScreen;

  AnimeModlue(this._animeDetailsScreen);

  @override
  getRoutes(){
    return {
      AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN : (context) => _animeDetailsScreen,
    };
  }

}