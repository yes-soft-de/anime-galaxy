import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_profile/response/following_activities_response/following_activities_response.dart';

class ProfileResponse {
  String statusCode;
  String msg;
  Data data;
  int followingNumber;
  List<FollowingActivitiesResponse> followingActivitiesResponse;
  List<FavouriteResponse> favourites;

  ProfileResponse({
    this.statusCode,
    this.msg,
    this.data  ,
    this.followingActivitiesResponse,
    this.favourites,
    this.followingNumber,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String userID;
  String userName;
  String location;
  String story;
  String image;

  Data(
      {this.id,
      this.userID,
      this.userName,
      this.location,
      this.story,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    userName = json['userName'];
    location = json['location'];
    story = json['story'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['location'] = this.location;
    data['story'] = this.story;
    data['image'] = this.image;
    return data;
  }
}
