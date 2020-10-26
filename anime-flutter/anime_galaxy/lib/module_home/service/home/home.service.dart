
import 'package:anime_galaxy/module_home/manager/home/home.manager.dart';
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:inject/inject.dart';

@provide
class HomeService{
  final HomeManager _homeManager;

  HomeService(this._homeManager);

  Future<HomeModel> getHomePageDetails() async{
    return await _homeManager.getHomePageDetails();
  }
}