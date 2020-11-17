class ActiveUsersResponse {
  int points;
  String userID;
  Null username;
  Null image;

  ActiveUsersResponse({this.points, this.userID, this.username, this.image});

  ActiveUsersResponse.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    userID = json['userID'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['userID'] = this.userID;
    data['username'] = this.username;
    data['image'] = this.image;
    return data;
  }
}
