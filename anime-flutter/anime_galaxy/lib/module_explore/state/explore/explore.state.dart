import 'package:anime_galaxy/module_explore/model/explore/explore_model.dart';

class ExploreState{}

class ExploreStateInit extends ExploreState{}

class ExploreStateFetching  extends ExploreState{}

class ExploreStateFetchingSuccess extends ExploreState{
  final ExploreModel data;

  ExploreStateFetchingSuccess(this.data);

}

class ExploreStateFetchingError extends ExploreState{}