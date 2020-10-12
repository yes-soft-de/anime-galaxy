
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/service/anime_details/anime_details.service.dart';
import 'package:anime_galaxy/module_anime/state/anime_details/anime_details.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:inject/inject.dart';

@provide
class AnimeDetailsStateManager {
  final AnimeDetailsService _animeDetailsService;

  final PublishSubject<AnimeDetailsState> _stateSubject = PublishSubject();
  Stream<AnimeDetailsState> get stateStream => _stateSubject.stream;

  AnimeDetailsStateManager(
      this._animeDetailsService
      );

  getAnimeDetails(int animeId){
    this._stateSubject.add(AnimeDetailsStateFetching());

    this._animeDetailsService.getAnimeDetails(animeId).then(
            (result) {
              if(result != null){
                this._stateSubject.add(AnimeDetailsStateFetchingSuccess(result));
              }
              else{
                this._stateSubject.add(AnimeDetailsStateFetchingError());
                Fluttertoast.showToast(msg: S.current.errorLoadingData);
              }
            });
  }

}