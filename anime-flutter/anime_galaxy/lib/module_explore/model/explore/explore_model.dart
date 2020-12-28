class ExploreModel{
  List<Series> worldRecommendedSeries;
  List<Series> recommendedSeriesByUser;
  List<ComingSoonSeries> comingSoonSeries;
  List<Category> categories;
//  List<ActiveUser> activeUsers;

  ExploreModel({
   this.worldRecommendedSeries,
//   this.activeUsers,
   this.comingSoonSeries,
   this.recommendedSeriesByUser,
    this.categories,
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
  String posterImage;

  ComingSoonSeries({
    this.name,
    this.image,
    this.category,
    this.posterImage,
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

class Category{
  int id;
  String name;
  String image;
  String description;

  Category({
    this.image,
    this.name,
    this.id,
    this.description,
});
}