class Urls {
  static const String DOMAIN = 'http://galaxy.yes-cloud.de';
  static const String BASE_API = DOMAIN + '/html/public/index.php';

  static const String IMAGES_UPLOAD_PATH = DOMAIN +'/upload';

  static const API_PROFILE = BASE_API + '/userprofile/';
  static const API_ANIME = BASE_API + '/anime';
  static const API_CATEGORY = BASE_API + '/category';
  static const API_EPISODE = BASE_API + '/episode/';
  static const API_ANIME_EPISODES = BASE_API + '/animeEpisodes/';
  static const API_ALL_COMMENTS = BASE_API + '/comments/';
  static const API_COMMENT = BASE_API + '/comment';
  static const API_ADD_FAVOURITE = BASE_API + '/favourite';
  static const API_ANIME_BY_CATEGORY = BASE_API + '/animeByCategory/';
  static const API_FAVOURITE_ANIMES = BASE_API + '/favouriteUser/';
  static const API_HIGHEST_RATED_ANIMES = BASE_API + '/getHighestRatedAnime';
  static const API_HIGHEST_RATED_ANIMES_BY_USER =  BASE_API + '/getHighestRatedAnime/';
  static const API_COMING_SOON_ANIMES = BASE_API + '/animeComingSoon';
  static const API_ANIME_YOU_MAY_LIKE = BASE_API + '/getMaybeYouLike/';
  static const API_USER_POINTS = BASE_API + '/grade/';
  static const API_EPISODES_COMING_SOON = BASE_API + '/episodesComingSoon';
  static const API_ACTIVE_USERS = BASE_API + '/top50';
  static const API_EPISODE_COMMENT = BASE_API + '/commentEpisode';
  static const API_ALL_EPISODE_COMMENTS = BASE_API + '/commentsEpisode/';
  static const API_FOLLOWING_ACTIVITIES = BASE_API + '/followersActivities/';
  static const API_FOLLOWING_USERS = BASE_API + '/following/';
  static const API_FOLLOW = BASE_API + '/following';
  static const API_REGISTER_POINTS = BASE_API + '/register-point';
  static const API_RATING_EPISODE = BASE_API + '/ratingEpisode';
  static const API_RATING_ANIME = BASE_API + '/rating';
  static const API_ANIME_INTERACTION = BASE_API + '/interaction';
  static const API_EPISODE_INTERACTION = BASE_API + '/interactionEpisode';
  static const API_ANIME_COMMENT_INTERACTION = BASE_API + '/interactionComment';
  static const API_EPISODE_COMMENT_INTERACTION = BASE_API + '/interactionCommentEpisode';
  static const API_NOTIFICATION = BASE_API + '/notifacations/';
  static const API_PREVIOUS_COMMENTS = BASE_API + '/usercomments/';
  static const API_SEARCH_ANIME = BASE_API + '/getanimebyname/';
  static const API_SEARCH_ANIME_BY_CATEGORY_AND_NAME = BASE_API + '/getanime/';


  static const API_UPLOAD_USER_IMAGE = BASE_API + '/uploadfile';

  static const API_SIGN_UP = BASE_API + '/user';
  static const API_CREATE_PROFILE = BASE_API + '/userprofile/';

  static const API_CREATE_TOKEN = BASE_API + '/login_check';
}
