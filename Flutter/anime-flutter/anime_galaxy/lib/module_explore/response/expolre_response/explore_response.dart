import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_explore/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_explore/response/comming_soon_response/comming_soon_response.dart';

class ExploreResponse {
  List<ActiveUsersResponse> activeUsers;
  List<AnimeResponse> worldRecommendedSeries;
  List<AnimeResponse> recommendedSeriesByYourFavourites;
  List<CommingSoonResponse> comingSoonSeries;
  List<CategoryResponse> categories;

  ExploreResponse({
    this.activeUsers,
    this.recommendedSeriesByYourFavourites,
    this.worldRecommendedSeries,
    this.comingSoonSeries,
    this.categories,
});
}