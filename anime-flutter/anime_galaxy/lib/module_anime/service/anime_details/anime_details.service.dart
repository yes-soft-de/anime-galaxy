import 'package:anime_galaxy/module_anime/manager/anime_details/anime_details.manager.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_anime/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_anime/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_anime/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_anime/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:inject/inject.dart';

@provide
class AnimeDetailsService {
  final AnimeDetailsManager _detailsManager;
  final AuthService _authService;

  AnimeDetailsService(this._detailsManager, this._authService);

  Future<AnimeModel> getAnimeDetails(int animeId) async {
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

//    var df = new DateFormat('yyyy');
//    var date = new DateTime.fromMicrosecondsSinceEpoch(response.publishDate.timestamp);
//    anime.showYear = df.format(date).toString();
//
    //TODO : change this when it return from backend
    anime.showYear = '2020';
    anime.about = response.description;
    anime.isFollowed = response.isFollowed;
    anime.categoryID = response.categoryID;
    anime.episodes = getEpisodes(response.episodes,response.categoryName);
    anime.previousRate = response.previousRate;

    return anime;
  }

  List<Episode> getEpisodes(List<EpisodeResponse> episodesResponse,String category) {
    List<Episode> episodes = [];

    episodesResponse.forEach((element) {
      Episode episode = new Episode(
          id: element.id,
          episodeNumber: element.episodeNumber,
          image: element.image,
          //TODO : change this later
          classification:category );
      episodes.add(episode);
    });
    return episodes;
  }

  List<Comment> getComments(List<Comments> commentResponse) {
    List<Comment> comments = [];
    List months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

    commentResponse.forEach((element) {
      var date = new DateTime.fromMicrosecondsSinceEpoch(element.creationDate.timestamp);
      Comment comment = new Comment(
          content: element.comment,
          userName:element.userName,
          userImage:element.image,
          date:' ${months[date.month+1]} ${date.day} ' ,
      );
      comments.add(comment);
    });
    return comments;
  }

  Future<bool> addComment(
      String comment, int animeId, bool spoilerAlert) async {
    String userId = await _authService.userID;

    CommentRequest commentRequest = new CommentRequest(
        comment: comment,
        animeID: animeId.toString(),
        spoilerAlert: spoilerAlert,
        userID: userId);

    return await _detailsManager.addComment(commentRequest);
  }

  Future<bool> addToFavourite(int animeId, int categoryId) async {
    String userId = await _authService.userID;
    Logger().info('anime_details.service', 'Favorate UID: $userId');
    FavouriteRequest request = new FavouriteRequest(
        categoryID: categoryId.toString(),
        animeID: animeId.toString(),
        userID: userId);

    return await _detailsManager.addToFavourite(request);
  }

  Future<bool> rateAnime(int animeId, int rateValue) async{
    String userId = await _authService.userID;

    RatingRequest request = new RatingRequest(
        userId: userId,
        animeId: animeId,
        rateValue: rateValue
    );

    return await _detailsManager.rateAnime(request);
  }
}
