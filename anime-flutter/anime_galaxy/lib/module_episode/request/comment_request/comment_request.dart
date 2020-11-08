

class CommentRequest{
  String userID;
  String episodeID;
  String comment;
  bool spoilerAlert;

  CommentRequest({
    this.comment,
    this.episodeID,
    this.userID,
    this.spoilerAlert,
});
}