
import 'package:anime_galaxy/module_explore/manager/explore/explore.manager.dart';
import 'package:anime_galaxy/module_explore/model/explore/explore_model.dart';
import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_explore/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_explore/response/comming_soon_response/comming_soon_response.dart';
import 'package:anime_galaxy/module_explore/response/expolre_response/explore_response.dart';
import 'package:inject/inject.dart';


@provide
class ExploreService{
  final ExploreManager _exploreManager;
  ExploreService(this._exploreManager);

  Future<ExploreModel> getExploreScreenContent()async{
    ExploreResponse response =  await _exploreManager.getExploreScreenContent();
//    List<ActiveUser> activeUsers = _getUsers(response.activeUsers);
    List<Series> worldRecommendedSeries = _getSeries(response.worldRecommendedSeries);
    List<Series> recommendedSeriesByUser = _getSeries(response.recommendedSeriesByYourFavourites);
    List<ComingSoonSeries> comingSoonSeries = _getComingSeries(response.comingSoonSeries);
    List<Category> categories = _getCategories(response.categories);

    return new ExploreModel(
      worldRecommendedSeries: worldRecommendedSeries,
//      activeUsers: activeUsers,
      recommendedSeriesByUser: recommendedSeriesByUser,
      comingSoonSeries: comingSoonSeries,
      categories: categories,
    );


  }

  List<ActiveUser> _getUsers(List<ActiveUsersResponse> usersResponse){
    List<ActiveUser> activeUsers = [];
    usersResponse.forEach((element) {
      activeUsers.add(new ActiveUser(
        id: element.userID,
        name: element.username,
        image: element.image
      ));
    });
    return activeUsers;
  }
  List<Category> _getCategories(List<CategoryResponse> categoriesResponse){
    List<Category> categories = [];
    categoriesResponse.forEach((element) {
      categories.add(
          new Category(
          id: element.id,
          name: element.name,
          image: element.image,
          coverImage: element.coverImage,
          description: element.description,
          titleShow: element.titleShow??true,
      ));
    });
    return categories;
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

  List<ComingSoonSeries> _getComingSeries(List<CommingSoonResponse> comingSoonResponse){

    List<ComingSoonSeries> series = [];
    comingSoonResponse.forEach((element) {
      series.add(new ComingSoonSeries(
        name: element.name,
        image: element.mainImage,
        category: element.categoryName,
        posterImage: element.posterImage,
      ));
    });
    return series;
  }
}