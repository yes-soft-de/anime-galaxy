
import 'package:anime_galaxy/module_anime/repository/anime_details/anime_details.repository.dart';
import 'package:anime_galaxy/module_anime/request/comment_request/comment_request.dart';
import 'package:anime_galaxy/module_anime/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_anime/request/rating_request/rating_request.dart';
import 'package:anime_galaxy/module_anime/response/anime_response/anime_response.dart';
 import 'package:inject/inject.dart';

@provide
class AnimeDetailsManager{
  final AnimeDetailsRepository _animeDetailsRepository;
  AnimeDetailsManager(this._animeDetailsRepository);

  Future<AnimeResponse> getAnimeDetails(animeId)async{
    return await _animeDetailsRepository.getAnimeDetails(animeId);
  }

  Future<bool> addComment(CommentRequest commentRequest)async{
    return await _animeDetailsRepository.addComment(commentRequest);
  }

  Future<bool> addToFavourite(FavouriteRequest request)async{
    return await _animeDetailsRepository.addToFavourite(request);
  }

  Future<bool> rateAnime(RatingRequest ratingRequest) async{
    return await _animeDetailsRepository.rateAnime(ratingRequest);
  }

  Future<bool> loveAnime(int animeId)async{
    return await _animeDetailsRepository.loveAnime(animeId);
  }
  Future<bool> loveComment(int commentId)async{
    return await _animeDetailsRepository.loveComment(commentId);
  }
}