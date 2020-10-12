import 'package:anime_galaxy/module_home/model/home_model/home_model.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

List<Series> watchedSeries =[
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
];

List<Series> mayLikedSeries =[
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
  new Series(name: 'دكتور ستون-Dr.Stone',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
];

List<Episode> episodes =[
  new Episode(  image :'',seriesName:'Hunter X Hunter',classification:'أكشن-مغامرة-شاونين',episodeNumber:21, season:3),
  new Episode(  image :'',seriesName:'Hunter X Hunter',classification:'أكشن-مغامرة-شاونين',episodeNumber:22, season:3),
  new Episode(  image :'',seriesName:'Hunter X Hunter',classification:'أكشن-مغامرة-شاونين',episodeNumber:23, season:3),
  new Episode(  image :'',seriesName:'Hunter X Hunter',classification:'أكشن-مغامرة-شاونين',episodeNumber:24, season:3),
];

@provide
class HomeRepository{
  ApiClient _httpClient;

  HomeRepository(this._httpClient);

  Future<HomeModel> getHomePageDetails() async{
    await Future.delayed(Duration(milliseconds: 2000));
    HomeModel result;
    result.points = 76;
    List<Series> watchedSeries = await getWatchedSeries();
    List<Series> mayLikedSeries = await getMayLikedSeries();
    List<Episode> episodes = await getEpisodes();

    result.watchedSeries = watchedSeries;
    result.mayLikeSeries = mayLikedSeries;
    result.newEpisodes = episodes;
    
    return result;
  }

  Future<List<Series>> getWatchedSeries()async{
    return watchedSeries;
  }
  Future<List<Series>> getMayLikedSeries()async{
    return mayLikedSeries;
  }
  Future<List<Episode>> getEpisodes()async{
    return episodes;
  }
}