
import 'package:anime_galaxy/module_episode/repository/episode_details/episode_details.repository.dart';
import 'package:anime_galaxy/module_episode/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_episode/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_episode/response/episode_response/episode_response.dart';
import 'package:inject/inject.dart';

@provide
class EpisodeDetailsManager{
  final EpisodeDetailsRepository _episodeDetailsRepository;
  EpisodeDetailsManager(this._episodeDetailsRepository);

  Future<EpisodeResponse> getEpisodeDetails(animeId)async{
    return await _episodeDetailsRepository.getEpisodeDetails(animeId);
  }

  Future<bool> addComment(CommentRequest commentRequest)async{
    return await _episodeDetailsRepository.addComment(commentRequest);
  }
  Future<bool> rateEpisode(RatingRequest ratingRequest) async{
    return await _episodeDetailsRepository.rateEpisode(ratingRequest);
  }
}