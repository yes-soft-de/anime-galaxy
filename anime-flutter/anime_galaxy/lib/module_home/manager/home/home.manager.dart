
import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_home/repository/home/home.repository.dart';
import 'package:inject/inject.dart';

@provide
class HomeManager{
  final HomeRepository _homeRepository;

  HomeManager(this._homeRepository);

  Future<HomeModel> getHomePageDetails() async{
     return await _homeRepository.getHomePageDetails();
  }


}