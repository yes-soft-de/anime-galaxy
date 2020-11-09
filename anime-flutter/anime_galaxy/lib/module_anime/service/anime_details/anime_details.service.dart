
import 'package:anime_galaxy/module_anime/manager/anime_details/anime_details.manager.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_anime/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_anime/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_anime/response/comment_response/comment_response.dart';
import 'package:anime_galaxy/module_anime/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_auth/presistance/auth_prefs_helper.dart';
 import 'package:inject/inject.dart';




@provide
class AnimeDetailsService{
  final AnimeDetailsManager _detailsManager;
  final AuthPrefsHelper _authPrefsHelper;

  AnimeDetailsService(this._detailsManager,this._authPrefsHelper);

  Future<AnimeModel> getAnimeDetails(int animeId) async{
    AnimeResponse response = await _detailsManager.getAnimeDetails(animeId);
    AnimeModel anime = new AnimeModel();

    anime.name = response.name;
    String image = response.mainImage;
  anime.image = image;
    anime.classification = response.categoryName;
    anime.rate = response.rating;
    anime.likesNumber = response.interactions.like;
    anime.commentsNumber = response.comments.length;
    anime.comments = getComments(response.comments);
    //TODO : change showYear to dynamic data from backend when it added
    anime.showYear = '2020';
    anime.about = response.description;
    anime.isFollowed = response.isFollowed;
    anime.categoryID = response.categoryID;
    anime.episodes = getEpisodes(response.episodes);

    return anime;
  }


  List<Episode> getEpisodes(List<EpisodeResponse> episodesResponse){
    List<Episode> episodes =[];

    episodesResponse.forEach((element) {
      Episode episode = new Episode(
        id: element.id,
        episodeNumber: element.episodeNumber,
        image: element.image ,
        //TODO : change this later
        classification: 'أكشن-شاونين'
      );
      episodes.add(episode);

    });
    return episodes;
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

  Future<bool> addComment(String comment,int animeId,bool spoilerAlert )async{
    String userId = await _authPrefsHelper.getUserId();

    CommentRequest commentRequest = new CommentRequest(
      comment: comment,
      animeID: animeId.toString(),
      spoilerAlert: spoilerAlert,
      userID: userId
    );

    return await _detailsManager.addComment(commentRequest);
  }

  Future<bool> addToFavourite(int animeId, int categoryId)async{
    String userId = await _authPrefsHelper.getUserId();

    FavouriteRequest request = new FavouriteRequest(
      categoryID: categoryId.toString(),
      animeID: animeId.toString(),
      userID: userId
    );

    return await _detailsManager.addToFavourite(request);
  }
}