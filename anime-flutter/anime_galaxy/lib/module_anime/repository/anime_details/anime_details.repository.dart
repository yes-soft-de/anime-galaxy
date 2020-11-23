
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_anime/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_anime/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_anime/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_anime/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_anime/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_anime/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:anime_galaxy/module_profile/repository/my_profile/my_profile.repository.dart';
import 'package:inject/inject.dart';

List<EpisodeResponse> episodes1 = [];
List<CommentResponse> comments1 = [];
bool isFollowed ;
int previousRate1 ;

@provide
class AnimeDetailsRepository{
  final ApiClient _httpClient;
  final AuthPrefsHelper _authPrefsHelper;
  AnimeDetailsRepository(this._httpClient,this._authPrefsHelper);

  Future<AnimeResponse> getAnimeDetails(int animeId) async{

    String token = await _authPrefsHelper.getToken();
    dynamic response = await _httpClient.get(Urls.API_ANIME+'/$animeId' );

    if(response == null) return null;

    String userId = await _authPrefsHelper.getUserId();

    AnimeResponse anime = new AnimeResponse();
    anime = AnimeResponse.fromJson(response['Data']);

    await Future.wait([
      _getEpisodes(animeId),
      _isFollowed(animeId , userId),
      _getPreviousRate(animeId,userId),
    ]);

    anime.episodes = episodes1;
    anime.isFollowed = isFollowed1;
    anime.previousRate = previousRate1;

    return anime;

  }


  Future<void> _getEpisodes(int animeId) async{
    dynamic response = await _httpClient.get(Urls.API_ANIME_EPISODES+'$animeId');
    if(response == null) return [];
    List<EpisodeResponse> episodes = [];
    dynamic res = response['Data'];

    for(int i=0; i<res.length ; i++){
      episodes.add(EpisodeResponse.fromJson(response['Data'][i]));
    }

    episodes1 = episodes;
  }

//  Future<void> _getComments(int animeId) async{
//    dynamic response = await _httpClient.get(Urls.API_ALL_COMMENTS+'$animeId');
//    if(response == null) return [];
//
//    List<CommentResponse> comments = [];
//    dynamic res = response['Data'];
//    for(int i=0; i<res.length ; i++){
//      comments.add(CommentResponse.fromJson(response['Data'][i]));
//    }
//   comments1 = comments;
//  }

  Future<void> _isFollowed(int animeId , String userId)async{
    dynamic favourites = await _httpClient.get(Urls.API_FAVOURITE_ANIMES+userId);
    if(favourites == null ) return false;

    dynamic res = favourites['Data'];
    for(int i=0 ; i <res.length ; i++){
      FavouriteResponse favourite = FavouriteResponse.fromJson(res[i]);
      if(animeId == favourite.animeID ) {
        isFollowed1 = true;
        return;
      }
    }

    isFollowed1 = false;
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

     return true;
   }

  Future<bool> rateAnime(RatingRequest ratingRequest) async{
    dynamic response = await _httpClient.post(Urls.API_RATING_ANIME, {
      'userID':ratingRequest.userId,
      'animeID':ratingRequest.animeId,
      'rateValue':ratingRequest.rateValue
    });
    return response == null ?
    null:
    response['status_code']=='201'?
    true:
    false;

  }

  Future<void> _getPreviousRate(int animeId,String userId)async{
    dynamic response = await _httpClient.get(Urls.API_RATING_ANIME+'/$animeId/'+userId);

    if(response == null ) {
      previousRate1 = 0;
      return;
    }

    String stringRate = response['Data']['avgRating'][0]['rating'];
     if( stringRate == null){
       previousRate1 = 0 ;
       return;
    }

    previousRate1 = double.parse(stringRate).round();

  }

  Future<bool> loveAnime(int animeId)async{
    String userId = await _authPrefsHelper.getUserId();
    dynamic response = await _httpClient.post(Urls.API_ANIME_INTERACTION, {
      'userID': userId,
      'animeID':animeId,
      'type':3
    });
    return response == null ?
    null:
    response['status_code']=='201'?
    true:
    false;
  }
  Future<bool> loveComment(int commentId)async{
    String userId = await _authPrefsHelper.getUserId();
    dynamic response = await _httpClient.post(Urls.API_ANIME_COMMENT_INTERACTION, {
      'userID': userId,
      'commentID':commentId,
      'type':3
    });
    return response == null ?
    null:
    response['status_code']=='201'?
    true:
    false;
  }

  Future<bool> unFollowAnime(int animeId)async{
    String userId = await _authPrefsHelper.getUserId();
    dynamic response = await _httpClient.delete(Urls.API_ADD_FAVOURITE+'/$animeId/$userId' );
    return response == null
        ? null
        : response['status_code'] == '401'
        ? true
        : false;
  }
}

