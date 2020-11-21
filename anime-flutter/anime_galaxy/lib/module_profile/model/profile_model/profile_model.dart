class ProfileModel {
  String name;
  String image;
  String about;
  List<Series> watchedSeries;
  int followingNumber;
  int seriesNumber;
  List<Activity> followingActivities;
  bool isFollowed;
  String createDate;

  ProfileModel({
    this.name,
    this.image,
    this.about,
    this.watchedSeries,
    this.followingNumber,
    this.seriesNumber,
    this.followingActivities,
    this.isFollowed,
    this.createDate,
  });


  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
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

class Activity{
  String userName;
  String action;
  String userImage;
  String date;

  Activity({
    this.userName,
    this.action,
    this.date,
    this.userImage,
});

}