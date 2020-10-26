

class InitAccountModel {
  int id;
 String name;
 String image;
 String description;
 List<Series> series;
 bool seriesHidden;

 InitAccountModel({
   this.id,
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
  int id;
  bool isSelected;

  Series({
    this.image,
    this.name,
    this.classification,
    this.id,
    this.isSelected = false,
  });
}