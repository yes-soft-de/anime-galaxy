

import 'package:anime_galaxy/anime_explor_list/manager/anime_explor_list_manager.dart';
import 'package:anime_galaxy/anime_explor_list/model/AllAnimeData.dart';
import 'package:inject/inject.dart';

@provide
class AnimeExplorListServices {


  AnimeExplorListManager _manager;

  AnimeExplorListServices(this._manager);



  Future<List<AllAnimeData>> getAllAnime() async {


    List<AllAnimeData> response =
        await this._manager.getAllAnime();

    if(response==null) return null;

    return response;



  }
}