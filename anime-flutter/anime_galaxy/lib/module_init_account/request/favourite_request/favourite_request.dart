class FavouriteRequest {
  String userID;
  String animeID;
  List<Categories> categories;

  FavouriteRequest({
    this.animeID,
    this.userID,
    this.categories,
  });
}

class Categories {
  String id;
  String name;

  Categories({
    this.id,
    this.name,
  });
}
