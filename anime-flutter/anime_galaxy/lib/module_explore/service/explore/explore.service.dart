
import 'package:anime_galaxy/module_explore/manager/explore/explore.manager.dart';
import 'package:anime_galaxy/module_explore/model/explore/explore_model.dart';
import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_explore/response/expolre_response/explore_response.dart';
import 'package:inject/inject.dart';

List<Series> comingSoonSeries = [
  new Series( id:1,name:'wind',image:'https://i.pinimg.com/236x/8e/99/52/8e995276505cdc0b02d44cedb2043933--anime-scenery-environment-design.jpg', category:'شاونين'),
  new Series( id:1,name:'wind',image:'https://i.pinimg.com/236x/8e/99/52/8e995276505cdc0b02d44cedb2043933--anime-scenery-environment-design.jpg', category:'شاونين'),
  new Series( id:1,name:'wind',image:'https://i.pinimg.com/236x/8e/99/52/8e995276505cdc0b02d44cedb2043933--anime-scenery-environment-design.jpg', category:'شاونين'),
  new Series( id:1,name:'wind',image:'https://i.pinimg.com/236x/8e/99/52/8e995276505cdc0b02d44cedb2043933--anime-scenery-environment-design.jpg' ,category:'شاونين'),

];
@provide
class ExploreService{
  final ExploreManager _exploreManager;
  ExploreService(this._exploreManager);

  Future<ExploreModel> getExploreScreenContent()async{
    ExploreResponse response =  await _exploreManager.getExploreScreenContent();
    List<ActiveUser> activeUsers = _getUsers(response.activeUsers);
    List<Series> worldRecommendedSeries = _getSeries(response.worldRecommendedSeries);
    List<Series> recommendedSeriesByUser = _getSeries(response.recommendedSeriesByYourFavourites);


    return new ExploreModel(
      worldRecommendedSeries: worldRecommendedSeries,
      activeUsers: activeUsers,
      recommendedSeriesByUser: recommendedSeriesByUser,
      //TODO : change this to response from the backend when there is data
      comingSoonSeries: comingSoonSeries
    );


  }

  List<ActiveUser> _getUsers(List<ActiveUsersResponse> usersResponse){
    List<ActiveUser> activeUsers = [];
    usersResponse.forEach((element) {
      activeUsers.add(new ActiveUser(
        id: element.userID,
        name: element.userID,
      ));
    });
    return activeUsers;
  }

  List<Series> _getSeries(List<AnimeResponse> animesResponse){
    List<Series> series = [];
    animesResponse.forEach((element) {
      series.add(new Series(
       name: element.animeName,
        id: element.id,
        image: element.mainImage,
        category: element.categoryName,
      ));
    });
    return series;
  }
}