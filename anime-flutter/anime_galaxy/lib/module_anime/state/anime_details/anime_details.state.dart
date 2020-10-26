
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';

class AnimeDetailsState{}

class AnimeDetailsStateInit extends AnimeDetailsState{}

class AnimeDetailsStateFetching  extends AnimeDetailsState{}

class AnimeDetailsStateFetchingSuccess extends AnimeDetailsState{
  final AnimeModel data;

  AnimeDetailsStateFetchingSuccess(this.data);

}

class AnimeDetailsStateFetchingError extends AnimeDetailsState{}

class AnimeDetailsStateCommentingInProgress extends AnimeDetailsState{}

class AnimeDetailsStateCommentingSuccess extends AnimeDetailsState{}

class AnimeDetailsStateCommentingError extends AnimeDetailsState{}