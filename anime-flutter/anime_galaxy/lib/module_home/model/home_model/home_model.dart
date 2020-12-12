
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
  int id;
  String image;
  String seriesName;
  String classification;
  int episodeNumber;
  int season;
  String posterImage;

  Episode({
    this.id,
    this.classification,
    this.image,
    this.episodeNumber,
    this.season,
    this.seriesName,
    this.posterImage,
});
}

class Series{
    int id;
    String image;
    String name;
    String classification;

    Series({
      this.id,
      this.image,
      this.name,
      this.classification,
});
}