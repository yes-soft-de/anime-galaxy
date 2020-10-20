

import 'package:anime_galaxy/anime_explor_list/model/AllAnimeData.dart';
import 'package:inject/inject.dart';






  class AnimeExplorListState{ }

  class AnimeExplorListStateInit extends AnimeExplorListState {}

  class AnimeExplorListStateFetching extends AnimeExplorListState {}

  class AnimeExplorListStateFetchingSuccess extends AnimeExplorListState {
  List<AllAnimeData> data;

  AnimeExplorListStateFetchingSuccess(this.data);
  }

  class AnimeExplorListStateFetchingError extends AnimeExplorListState {}

