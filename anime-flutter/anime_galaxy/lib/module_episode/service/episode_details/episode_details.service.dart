

import 'package:anime_galaxy/module_episode/manager/episode_details/episode_details.manager.dart';
import 'package:anime_galaxy/module_episode/model/episode_model/episode_model.dart';
import 'package:anime_galaxy/module_episode/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_episode/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_episode/response/episode_response/episode_response.dart';
import 'package:inject/inject.dart';

@provide
class EpisodeDetailsService{
  final EpisodeDetailsManager _detailsManager;

  EpisodeDetailsService(this._detailsManager);

  Future<EpisodeModel> getEpisodeDetails(int episodeId) async{
    EpisodeResponse response = await _detailsManager.getEpisodeDetails(episodeId);
    EpisodeModel episode = new EpisodeModel();

    episode.name = response.animeName;
    //TODO : change this
    String image = response.image.substring(response.image.lastIndexOf('http'));
    episode.image = image;
    //TODO : category should be added to response from backend
    episode.classification = 'شاونين';
    episode.rate = response.rating;
    episode.likesNumber = response.interactions.like;
    episode.commentsNumber = response.comments.length;
    episode.comments = getComments(response.episodeComments);
    //TODO : change showYear to dynamic data from backend when it added
    episode.showYear = '2020';
    episode.about = response.description;


    return episode;
  }


  List<Comment> getComments(List<CommentResponse> commentResponse){
    List<Comment> comments =[];

    commentResponse.forEach((element) {
      Comment comment = new Comment(
          content: element.comment,
          //TODO : change these below
          userName:'zoz',
          userImage:'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w' ,
          date: '21 Jun'
      );
      comments.add(comment);

    });
    return comments;
  }

  Future<bool> addComment(String comment,int episodeId,bool spoilerAlert )async{
    CommentRequest commentRequest = new CommentRequest(
      comment: comment,
      episodeID: episodeId.toString(),
      spoilerAlert: spoilerAlert,
      //TODO : change this when implement auth
      userID: 'zoz'
    );

    return await _detailsManager.addComment(commentRequest);
  }
}