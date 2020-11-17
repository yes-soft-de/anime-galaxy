import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_home/response/anime_response/anime_response.dart';
import 'package:anime_galaxy/module_home/response/coming_soon_episodes/coming_soon_episodes.dart';
import 'package:anime_galaxy/module_home/response/home_response/home_response.dart';
import 'package:anime_galaxy/module_home/response/points/points_response.dart';
import 'package:anime_galaxy/module_home/response/watched_series_response/watched_series_response.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';



@provide
class HomeRepository {
  final ApiClient _httpClient;

  HomeRepository(this._httpClient);

  Future<HomeResponse> getHomePageDetails(String userId) async {
    PointsResponse points = await getUserPoints(userId);
    List<ComingSoonEpisodesResponse> episodes = await getEpisodesComingSoon();
    List<WatchedSeriesResponse> watchedSeries = await getWatchedSeries(userId);
    List<AnimeResponse> mayLikedSeries = await getMayLikedSeries(userId);

    HomeResponse result = new HomeResponse(
        watchedSeries: watchedSeries,
        comingSoonEpisodes: episodes,
        mayLikedSeries: mayLikedSeries,
        points: points);

    return result;
  }

  Future<List<WatchedSeriesResponse>> getWatchedSeries(String userId) async {
    dynamic response =
        await _httpClient.get(Urls.API_FAVOURITE_ANIMES + '$userId');

    if (response == null) return [];

    List<WatchedSeriesResponse> series = [];
    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      series.add(WatchedSeriesResponse.fromJson(res[i]['animeID']));
    }

    return series;
  }

  Future<AnimeResponse> getAnime(int animeId) async {
    dynamic response = await _httpClient.get(Urls.API_ANIME + '/$animeId');

    if (response == null) return null;

    AnimeResponse anime = new AnimeResponse();
    anime = AnimeResponse.fromJson(response['Data']);

    return anime;
  }

  Future<List<AnimeResponse>> getMayLikedSeries(String userId) async {
    dynamic response =
        await _httpClient.get(Urls.API_ANIME_YOU_MAY_LIKE + '$userId');
    if (response == null) return [];

    List<AnimeResponse> series = [];
    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      //TODO : fetch it directly from response
      series.add(await getAnime(res[i]['id']));
    }

    return series;
  }

  Future<List<ComingSoonEpisodesResponse>> getEpisodesComingSoon() async {
    dynamic response = await _httpClient.get(Urls.API_EPISODES_COMING_SOON);

    if (response == null) return [];

    List<ComingSoonEpisodesResponse> episodes = [];

    dynamic res = response['Data'];
    for (int i = 0; i < res.length; i++) {
      episodes.add(ComingSoonEpisodesResponse.fromJson(res[i]));
    }

    return episodes;
  }

  Future<PointsResponse> getUserPoints(String userId) async {
    if (userId == null) {
      return null;
    }
    dynamic response = await _httpClient.get(Urls.API_USER_POINTS + userId);
    if (response == null) return null;

    dynamic res = response['Data'];
    return PointsResponse.fromJson(res);
  }
}
