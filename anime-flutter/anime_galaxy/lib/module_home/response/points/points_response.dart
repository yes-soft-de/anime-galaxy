class PointsResponse {
  int id;
  String userID;
  int points;

  PointsResponse({this.id, this.userID, this.points});

  PointsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['points'] = this.points;
    return data;
  }
}
