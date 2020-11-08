
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_episode/service/episode_details/episode_details.service.dart';
import 'package:anime_galaxy/module_episode/state/episode_details/episode_details.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EpisodeDetailsStateManager {
  final EpisodeDetailsService _animeDetailsService;

  final PublishSubject<EpisodeDetailsState> _stateSubject = PublishSubject();
  Stream<EpisodeDetailsState> get stateStream => _stateSubject.stream;

  EpisodeDetailsStateManager(
      this._animeDetailsService
      );

  void getEpisodeDetails(int episodeId){
    this._stateSubject.add(EpisodeDetailsStateFetching());

    this._animeDetailsService.getEpisodeDetails(episodeId).then(
            (result) {
              if(result != null){
                this._stateSubject.add(EpisodeDetailsStateFetchingSuccess(result));
              }
              else{
                this._stateSubject.add(EpisodeDetailsStateFetchingError());
                Fluttertoast.showToast(msg: S.current.errorLoadingData);
              }
            });
  }
  
  void addComment(String comment,int episodeId,bool spoilerAlert){
    this._stateSubject.add(EpisodeDetailsStateCommentingInProgress());
    
    this._animeDetailsService.addComment(comment, episodeId, spoilerAlert).then((value) {
      if(value == null || value == false){
        Fluttertoast.showToast(msg: S.current.ommentingError);
        this._stateSubject.add(EpisodeDetailsStateCommentingError());
      }else{
        this._stateSubject.add(EpisodeDetailsStateCommentingSuccess());
      }
    });
  }

}