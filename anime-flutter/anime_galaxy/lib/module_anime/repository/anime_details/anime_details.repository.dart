
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_anime/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_anime/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_anime/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_anime/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';



@provide
class AnimeDetailsRepository{
  final ApiClient _httpClient;

  AnimeDetailsRepository(this._httpClient);

  Future<AnimeResponse> getAnimeDetails(int animeId) async{

    dynamic response = await _httpClient.get(Urls.API_ANIME+'/$animeId');

    if(response == null) return null;


    AnimeResponse anime = new AnimeResponse();
    anime = AnimeResponse.fromJson(response['Data']);
    anime.episodes = await _getEpisodes(animeId);
    anime.comments = await _getComments(animeId);
    //TODO : change userId to logged in userId
    anime.isFollowed = await _isFollowed(animeId , 'zoz');

    return anime;

  }


  Future<List<EpisodeResponse>> _getEpisodes(int animeId) async{
    dynamic response = await _httpClient.get(Urls.API_ANIME_EPISODES+'$animeId');
    List<EpisodeResponse> episodes = [];
    dynamic res = response['Data'];

    for(int i=0; i<res.length ; i++){
      episodes.add(EpisodeResponse.fromJson(response['Data'][i]));
    }

    return episodes;
  }

  Future<List<CommentResponse>> _getComments(int animeId) async{
    dynamic response = await _httpClient.get(Urls.API_ALL_COMMENTS+'$animeId');
    List<CommentResponse> comments = [];
    dynamic res = response['Data'];
    for(int i=0; i<res.length ; i++){
      comments.add(CommentResponse.fromJson(response['Data'][i]));
    }
    return comments;
  }

  Future<bool> _isFollowed(int animeId , String userId)async{
    dynamic favourites = await _httpClient.get(Urls.API_FAVOURITE_ANIMES+userId);
    if(favourites == null ) return false;

    dynamic res = favourites['Data'];
    for(int i=0 ; i <res.length ; i++){
      FavouriteResponse favourite = FavouriteResponse.fromJson(res[i]);
      if(animeId == favourite.animeID ) return true;
    }

    return false;
  }

   Future<bool> addComment(CommentRequest commentRequest) async{
    dynamic response = await _httpClient.post(Urls.API_COMMENT, {
      'userID':commentRequest.userID,
      'animeID':commentRequest.animeID,
      'comment':commentRequest.comment,
      'spoilerAlert':commentRequest.spoilerAlert
    });
    return response == null ?
        null:
        response['status_code']=='201'?
            true:
            false;

   }

   Future<bool> addToFavourite(FavouriteRequest request)async{
     dynamic response = await _httpClient.post(Urls.API_ADD_FAVOURITE, {
       'userID':request.userID,
       'animeID':request.animeID,
       'categoryID':request.categoryID
     });

     if(response == null) return null;
   }


}