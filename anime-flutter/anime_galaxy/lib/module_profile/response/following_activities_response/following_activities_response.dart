class FollowingActivitiesResponse {
  String userName;
  String animeName;

  FollowingActivitiesResponse(this.userName, this.animeName);

  FollowingActivitiesResponse.fromJson(Map<String, dynamic> jsonData) {
    userName = jsonData['userName'];
    animeName = jsonData['animeName'];
  }
}
