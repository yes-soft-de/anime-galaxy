

class SearchModel{
  int animeId;
  String animeName;
  String animeCategory;
  String animeImage;
  String rating;
  int comments;
  int episodesCount;
  String generalRating;
  String ageGroup;
  int likes;

  SearchModel({
    this.animeId,
    this.animeName,
    this.animeCategory,
    this.animeImage,
    this.generalRating,
    this.ageGroup,
    this.comments,
    this.rating,
    this.episodesCount,
    this.likes,
  });
}
