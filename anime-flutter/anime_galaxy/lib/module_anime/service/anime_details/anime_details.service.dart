import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_anime/manager/anime_details/anime_details.manager.dart';
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_anime/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_anime/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_anime/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_anime/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_anime/response/episode_response/episode_response.dart';
import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';
import 'package:intl/intl.dart';

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
    anime.likesNumber = response.interactions.love.toString();
    anime.commentsNumber = response.comments.length;
    anime.comments = getComments(response.comments);
    anime.ageGroup = response.ageGroup;
    anime.generalRating = response.generalRating;

    var df = new DateFormat('yyyy');
    var date = new DateTime.fromMillisecondsSinceEpoch(response.publishDate.timestamp *1000);
    anime.showYear = df.format(date).toString();


    anime.about = response.description;
    anime.isFollowed = response.isFollowed;
    anime.isLoved = response.interactions.isLoved;
    anime.categoryID = response.categoryID;
    anime.episodes = getEpisodes(response.episodes,response.categoryName);
    anime.previousRate = response.previousRate;
    anime.trailerVideo = response.trailerVideo;

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
    var df = new DateFormat('dd/MM');

    commentResponse.forEach((element) {
      var date = new DateTime.fromMillisecondsSinceEpoch(element.creationDate.timestamp * 1000);
      String image = element.image??'';
      Comment comment = new Comment(
        content: element.comment,
        userName:element.userName,
        id: element.id,
        userId: element.userID,
        likesNumber: element.commentInteractions.love.toString(),
        userImage:Urls.IMAGES_UPLOAD_PATH+'/'+image,
      //  date:' ${months[date.month+1]} ${date.day} ' ,
        date: df.format(date).toString()??'',
        isLoved: element.commentInteractions.isLoved,
        spoilerAlert: element.spoilerAlert,
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

  Future<bool> loveAnime(int animeId)async{
    return await _detailsManager.loveAnime(animeId);
  }
  Future<bool> loveComment(int commentId)async{
    return await _detailsManager.loveComment(commentId);
  }

  Future<bool> unFollowAnime(int animeId)async{
    return await _detailsManager.unFollowAnime(animeId);
  }
}
