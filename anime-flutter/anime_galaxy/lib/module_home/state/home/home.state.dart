
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';

class HomeState{}

class HomeStateInit extends HomeState{}

class HomeStateFetching  extends HomeState{}

class HomeStateFetchingSuccess extends HomeState{
  final HomeModel data;

  HomeStateFetchingSuccess(this.data);

}

class HomeStateFetchingError extends HomeState{}