class ExploreModel{
  List<Series> worldRecommendedSeries;
  List<Series> recommendedSeriesByUser;
  List<ComingSoonSeries> comingSoonSeries;
  List<ActiveUser> activeUsers;

  ExploreModel({
   this.worldRecommendedSeries,
   this.activeUsers,
   this.comingSoonSeries,
   this.recommendedSeriesByUser,
});
}

class Series{
  int id;
  String name;
  String image;
  String category;

  Series({
    this.id,
    this.name,
    this.image,
    this.category,
  });


}
class ComingSoonSeries{
  String name;
  String image;
  String category;

  ComingSoonSeries({
    this.name,
    this.image,
    this.category,
  });


}

class ActiveUser{
  String id;
  String name;
  String image;

  ActiveUser({
    this.name,
    this.id,
    this.image,
});
}