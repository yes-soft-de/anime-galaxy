import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/home_response/home_response.dart';
import 'package:anime_galaxy/module_home/response/points/points_response.dart';
import 'package:anime_galaxy/module_home/response/series_you_may_like_response/series_you_may_like_response.dart';
import 'package:anime_galaxy/module_home/response/watched_series_response/watched_series_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

PointsResponse points1 = new PointsResponse();
List<ComingSoonEpisodesResponse> episodes1 = [];
List<WatchedSeriesResponse> watchedSeries1 = [];
List<SeriesYouMayLikeResponse> mayLikedSeries1 = [];

@provide
class HomeRepository {
  final ApiClient _httpClient;

  HomeRepository(this._httpClient);

  Future<HomeResponse> getHomePageDetails(String userId) async {
//    PointsResponse points = await getUserPoints(userId);
//    List<ComingSoonEpisodesResponse> episodes = await getEpisodesComingSoon();
//    List<WatchedSeriesResponse> watchedSeries = await getWatchedSeries(userId);
//    List<AnimeResponse> mayLikedSeries = await getMayLikedSeries(userId);

    await Future.wait([
      getUserPoints(userId),
      getEpisodesComingSoon(),
      getWatchedSeries(userId),
      getMayLikedSeries(userId)
    ]);

    HomeResponse result = new HomeResponse(
        watchedSeries: watchedSeries1,
        comingSoonEpisodes: episodes1,
        mayLikedSeries: mayLikedSeries1,
        points: points1
    );

    return result;
  }

  Future<void> getWatchedSeries(String userId) async {
    dynamic response =
        await _httpClient.get(Urls.API_FAVOURITE_ANIMES + '$userId');

    if (response == null) return [];

    List<WatchedSeriesResponse> series = [];
    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      series.add(WatchedSeriesResponse.fromJson(res[i]));
    }

    watchedSeries1 = series;
  }


  Future<void> getMayLikedSeries(String userId) async {
    dynamic response =
        await _httpClient.get(Urls.API_ANIME_YOU_MAY_LIKE + '$userId');
    if (response == null) return [];

    List<SeriesYouMayLikeResponse> series = [];
    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      series.add(SeriesYouMayLikeResponse.fromJson(res[i]));
    }

    mayLikedSeries1 = series;
  }

  Future<void> getEpisodesComingSoon() async {
    dynamic response = await _httpClient.get(Urls.API_EPISODES_COMING_SOON);

    if (response == null) return [];

    List<ComingSoonEpisodesResponse> episodes = [];

    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      episodes.add(ComingSoonEpisodesResponse.fromJson(res[i]));
    }

    episodes1 = episodes;
  }

  Future<void> getUserPoints(String userId) async {
    if (userId == null) {
      return null;
    }
    dynamic response = await _httpClient.get(Urls.API_USER_POINTS + userId);
    if (response == null) return null;

    dynamic res = response['Data'];
    points1 = PointsResponse.fromJson(res);

  }
}
