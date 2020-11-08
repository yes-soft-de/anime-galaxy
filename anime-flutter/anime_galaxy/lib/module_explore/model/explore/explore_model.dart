class ExploreModel{
  List<Series> worldRecommendedSeries;
  List<Series> recommendedSeriesByUser;
  List<Series> comingSoonSeries;
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
  double rating;
  String image;
  String category;

  Series({
    this.id,
    this.name,
    this.image,
    this.rating,
    this.category,
});
}

class ActiveUser{
  String id;
  String name;

  ActiveUser({
    this.name,
    this.id,
});
}