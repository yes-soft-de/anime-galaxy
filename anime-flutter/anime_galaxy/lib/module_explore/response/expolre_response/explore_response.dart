import 'package:anime_galaxy/module_explore/response/active_users_response/active_users_response.dart';
import 'package:anime_galaxy/module_explore/response/anime_response/anime_response.dart';

class ExploreResponse {
  List<ActiveUsersResponse> activeUsers;
  List<AnimeResponse> worldRecommendedSeries;
  List<AnimeResponse> recommendedSeriesByYourFavourites;

  ExploreResponse({
    this.activeUsers,
    this.recommendedSeriesByYourFavourites,
    this.worldRecommendedSeries,
});
}