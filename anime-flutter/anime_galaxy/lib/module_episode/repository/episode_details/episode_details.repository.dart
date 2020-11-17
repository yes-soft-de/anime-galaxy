

import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_episode/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_episode/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_episode/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_episode/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class EpisodeDetailsRepository{
  final ApiClient _httpClient;

  EpisodeDetailsRepository(this._httpClient);

  Future<EpisodeResponse> getEpisodeDetails(int episodeId) async{

    dynamic response = await _httpClient.get(Urls.API_EPISODE+'$episodeId');

    if(response == null) return null;


    EpisodeResponse episode = new EpisodeResponse();
    episode = EpisodeResponse.fromJson(response['Data']);
    episode.episodeComments = await _getComments(episodeId);

    return episode;

  }




  Future<List<CommentResponse>> _getComments(int episodeId) async{
    dynamic response = await _httpClient.get(Urls.API_ALL_EPISODE_COMMENTS+'$episodeId');
    if(response == null ) return [];

    List<CommentResponse> comments = [];
    dynamic res = response['Data'];
    for(int i=0; i<res.length ; i++){
      comments.add(CommentResponse.fromJson(response['Data'][i]));
    }
    return comments;
  }



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
}