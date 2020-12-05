

import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
import 'package:anime_galaxy/module_episode/manager/episode_details/episode_details.manager.dart';
import 'package:anime_galaxy/module_episode/model/episode_model/episode_model.dart';
import 'package:anime_galaxy/module_episode/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_episode/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_episode/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_episode/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/utils/time/time_formatter.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';

@provide
class EpisodeDetailsService{
  final EpisodeDetailsManager _detailsManager;
  final AuthPrefsHelper _authPrefsHelper;

  EpisodeDetailsService(this._detailsManager,this._authPrefsHelper);

  Future<EpisodeModel> getEpisodeDetails(int episodeId) async{
    EpisodeResponse response = await _detailsManager.getEpisodeDetails(episodeId);
    EpisodeModel episode = new EpisodeModel();

    episode.name = response.animeName;
    String image = response.image ;
    episode.image = image;
    episode.classification = response.categoryName;
    episode.rate = response.rating;
    episode.likesNumber = response.interactions.love.toString();
    episode.commentsNumber = response.comments.length;
    episode.comments = await getComments(response.comments);

    int seconds=0;
    if(response.duration!= null)  seconds = response.duration.timestamp;
    episode.duration = TimeFormatter.secondsToTime(seconds);

    var df = new DateFormat('yyyy');
    var date = response.publishDate != null?
                            new DateTime.fromMillisecondsSinceEpoch(response.publishDate.timestamp *1000):
                            DateTime.now();

    episode.showYear = df.format(date).toString();
    episode.about = response.description;
    episode.previousRate = response.previousRate;
    episode.isLoved = response.interactions.isLoved;


    return episode;
  }


  Future< List<Comment>> getComments(List<Comments> commentResponse)async{
    List<Comment> comments =[];
    List months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var df = new DateFormat('dd/MM');

    commentResponse.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(element.creationDate.timestamp * 1000);
      Comment comment = new Comment(
        content: element.comment,
        userName: element.userName,
        userId: element.userID,
        id: element.id,
        likesNumber: element.commentInteractions.love.toString(),
        userImage:element.image,
        //  date:' ${months[date.month+1]} ${date.day} ' ,
        date: df.format(date).toString()??'',
        isLoved: element.commentInteractions.isLoved,
      );
      comments.add(comment);

    });
    return comments;
  }

  Future<bool> addComment(String comment,int episodeId,bool spoilerAlert )async{
    String userId = await _authPrefsHelper.getUserId();

    CommentRequest commentRequest = new CommentRequest(
        comment: comment,
        episodeID: episodeId.toString(),
        spoilerAlert: spoilerAlert,
        userID: userId
    );

    return await _detailsManager.addComment(commentRequest);
  }

  Future<bool> rateEpisode(int episodeId, int rateValue) async{
    String userId = await _authPrefsHelper.getUserId();

    RatingRequest request = new RatingRequest(
        userId: userId,
        episodeId: episodeId,
        rateValue: rateValue
    );

    return await _detailsManager.rateEpisode(request);
  }

  Future<bool> loveEpisode(int episodeId)async{
    return await _detailsManager.loveEpisode(episodeId);
  }
  Future<bool> loveComment(int commentId)async{
    return await _detailsManager.loveComment(commentId);
  }
}