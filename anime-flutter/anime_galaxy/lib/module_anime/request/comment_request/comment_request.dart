

class CommentRequest{
  String userID;
  String animeID;
  String comment;
  bool spoilerAlert;

  CommentRequest({
    this.comment,
    this.animeID,
    this.userID,
    this.spoilerAlert,
});
}