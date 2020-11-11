
import 'package:anime_galaxy/module_episode/model/episode_model/episode_model.dart';

class EpisodeDetailsState{}

class EpisodeDetailsStateInit extends EpisodeDetailsState{}

class EpisodeDetailsStateFetching  extends EpisodeDetailsState{}

class EpisodeDetailsStateFetchingSuccess extends EpisodeDetailsState{
  final EpisodeModel data;

  EpisodeDetailsStateFetchingSuccess(this.data);

}

class EpisodeDetailsStateFetchingError extends EpisodeDetailsState{}
///----------------------------------------------
class EpisodeDetailsStateCommentingInProgress extends EpisodeDetailsState{}

class EpisodeDetailsStateCommentingSuccess extends EpisodeDetailsState{}

class EpisodeDetailsStateCommentingError extends EpisodeDetailsState{}

///----------------------------------------------

class EpisodeDetailsStateRatingSuccess extends EpisodeDetailsState{}

class EpisodeDetailsStateRatingError extends EpisodeDetailsState{}