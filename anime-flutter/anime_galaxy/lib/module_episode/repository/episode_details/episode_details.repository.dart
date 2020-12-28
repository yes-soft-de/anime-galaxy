

import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_episode/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_episode/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_episode/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_episode/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

//List<CommentResponse> comments1 = [];
int previousRate1 ;

@provide
class EpisodeDetailsRepository{
  final ApiClient _httpClient;
  final AuthPrefsHelper _authPrefsHelper;
  final AuthService _authService;

  EpisodeDetailsRepository(
      this._httpClient,
      this._authPrefsHelper,
      this._authService,
      );

  Future<EpisodeResponse> getEpisodeDetails(int episodeId) async{

    String token = await _authService.getToken();

    dynamic response = await _httpClient.get(Urls.API_EPISODE+'$episodeId',token: token);

    if(response == null) return null;

    String userId = await _authPrefsHelper.getUserId();

    EpisodeResponse episode = new EpisodeResponse();
    episode = EpisodeResponse.fromJson(response['Data']);
    await Future.wait([
//      _getComments(episodeId),
      _getPreviousRate(episodeId, userId)
    ]);


    episode.previousRate = previousRate1;

    return episode;

  }




//  Future<void> _getComments(int episodeId) async{
//    dynamic response = await _httpClient.get(Urls.API_ALL_EPISODE_COMMENTS+'$episodeId');
//    if(response == null ) return  ;
//
//    List<CommentResponse> comments = [];
//    dynamic res = response['Data'];
//    for(int i=0; i<res.length ; i++){
//      comments.add(CommentResponse.fromJson(response['Data'][i]));
//    }
//    comments1 = comments;
//  }



  Future<bool> addComment(CommentRequest commentRequest) async{
    dynamic response = await _httpClient.post(Urls.API_EPISODE_COMMENT, {
      'userID':commentRequest.userID,
      'episodeID':commentRequest.episodeID,
      'comment':commentRequest.comment,
      'spoilerAlert':commentRequest.spoilerAlert
    });
    print('$response');
    return response == null ?
    null:
    response['status_code']=='201'?
    true:
    false;

  }

  Future<bool> rateEpisode(RatingRequest ratingRequest) async{
    dynamic response = await _httpClient.post(Urls.API_RATING_EPISODE, {
      'userID':ratingRequest.userId,
      'episodeID':ratingRequest.episodeId,
      'rateValue':ratingRequest.rateValue
    });
    return response == null ?
    null:
    response['status_code']=='201'?
    true:
    false;

  }

  Future<void> _getPreviousRate(int episodeId,String userId)async{
    dynamic response = await _httpClient.get(Urls.API_RATING_EPISODE+'/$episodeId/'+userId);

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

  Future<bool> loveEpisode(int episodeId)async{
    String userId = await _authPrefsHelper.getUserId();
    dynamic response = await _httpClient.post(Urls.API_EPISODE_INTERACTION, {
      'userID': userId,
      'episodeID':episodeId,
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
    dynamic response = await _httpClient.post(Urls.API_EPISODE_COMMENT_INTERACTION, {
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
}