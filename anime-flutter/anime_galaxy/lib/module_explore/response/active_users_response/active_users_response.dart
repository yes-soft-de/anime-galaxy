class ActiveUsersResponse {
  int points;
  String userID;

  ActiveUsersResponse({this.points, this.userID});

  ActiveUsersResponse.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['userID'] = this.userID;
    return data;
  }
}
