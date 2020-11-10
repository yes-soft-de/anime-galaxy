class FollowingUsersResponse {
  String userID;
  String friendID;

  FollowingUsersResponse({this.userID, this.friendID});

  FollowingUsersResponse.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    friendID = json['friendID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['friendID'] = this.friendID;
    return data;
  }
}
