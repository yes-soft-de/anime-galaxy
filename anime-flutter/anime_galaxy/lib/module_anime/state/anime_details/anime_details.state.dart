
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';

class AnimeDetailsState{}

class AnimeDetailsStateInit extends AnimeDetailsState{}

class AnimeDetailsStateFetching  extends AnimeDetailsState{}

class AnimeDetailsStateFetchingSuccess extends AnimeDetailsState{
  final AnimeModel data;

  AnimeDetailsStateFetchingSuccess(this.data);

}

class AnimeDetailsStateFetchingError extends AnimeDetailsState{}

///--------------------------------------------
///
class AnimeDetailsStateCommentingInProgress extends AnimeDetailsState{}

class AnimeDetailsStateCommentingSuccess extends AnimeDetailsState{}

class AnimeDetailsStateCommentingError extends AnimeDetailsState{}

///---------------------------------------------
///
class AnimeDetailsStateAddToFavouriteInProgress extends AnimeDetailsState{}

class AnimeDetailsStateAddToFavouriteSuccess extends AnimeDetailsState{}

class AnimeDetailsStateAddToFavouriteError extends AnimeDetailsState{}

///----------------------------------------------

class AnimeDetailsStateRatingSuccess extends AnimeDetailsState{}

class AnimeDetailsStateRatingError extends AnimeDetailsState{}
///----------------------------------------------

class AnimeDetailsStateLoveSuccess extends AnimeDetailsState{}

class AnimeDetailsStateLoveError extends AnimeDetailsState{}
///----------------------------------------------

class AnimeDetailsStateLoveCommentSuccess extends AnimeDetailsState{
  int data;
  AnimeDetailsStateLoveCommentSuccess(data);
}

class AnimeDetailsStateLoveCommentError extends AnimeDetailsState{}
///----------------------------------------------

class AnimeDetailsStateUnFollowSuccess extends AnimeDetailsState{}

class AnimeDetailsStateUnFollowError extends AnimeDetailsState{}