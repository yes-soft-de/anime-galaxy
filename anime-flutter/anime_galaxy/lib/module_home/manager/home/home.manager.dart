
import 'package:anime_galaxy/module_home/repository/home/home.repository.dart';
import 'package:anime_galaxy/module_home/response/home_response/home_response.dart';
import 'package:inject/inject.dart';

@provide
class HomeManager{
  final HomeRepository _homeRepository;

  HomeManager(this._homeRepository);

  Future<HomeResponse> getHomePageDetails(String userId) async{
     return await _homeRepository.getHomePageDetails(userId);
  }


}