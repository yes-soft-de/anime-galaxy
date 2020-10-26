

class InitAccountModel {
 String name;
 String image;
 String description;
 List<Series> series;
 bool seriesHidden;

 InitAccountModel({
   this.description,
   this.name,
   this.image,
   this.series,
   this.seriesHidden = true,
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