
class CreateProfileRequest {
  String userName;
  String userID;
  String story;
  String image;
  String location;
  String cover;

  CreateProfileRequest({
    this.userID,
    this.story,
    this.userName,
    this.location,
    this.image,
    this.cover,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': this.userID,
      'userName': this.userName,
      'story': this.story,
      'location': this.location,
      'image': this.image,
      'cover': this.cover,
    };
  }
}
