
class HomeModel{
  int points;
  List<Series> watchedSeries;
  List<Series> mayLikeSeries;
  List<Episode> newEpisodes;

  HomeModel({
    this.points,
    this.newEpisodes,
    this.mayLikeSeries,
    this.watchedSeries,

});
}

class Episode{
  String image;
  String seriesName;
  String classification;
  int episodeNumber;
  int season;

  Episode({
    this.classification,
    this.image,
    this.episodeNumber,
    this.season,
    this.seriesName,
});
}

class Series{
    String image;
    String name;
    String classification;

    Series({
      this.image,
      this.name,
      this.classification,
});
}