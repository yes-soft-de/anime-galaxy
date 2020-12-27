export class AdminConfig {
  // An Example | Delete The Content When Started
  // source api
  public static sourceAPI                   = 'http://34.71.153.58/html/public/index.php/';

  // All Application Api
  public static loginAPI                    = AdminConfig.sourceAPI + 'login_check';
  public static userAPI                     = AdminConfig.sourceAPI + 'user';

  // Categories     
  public static categoryAPI                 = AdminConfig.sourceAPI + 'category';
  // public static category                 = AdminConfig.sourceAPI + 'category';

  // Animes     
  public static animeAPI                    = AdminConfig.sourceAPI + 'anime';
  
  // Episode      
  public static episodeAPI                  = AdminConfig.sourceAPI + 'episode';
  public static animeEpisodesAPI            = AdminConfig.sourceAPI + 'animeEpisodes';
  public static animeSeasonEpisodesAPI      = AdminConfig.sourceAPI + 'episode/animeID';
  public static episodeComingSoonAPI        = AdminConfig.sourceAPI + 'episodesComingSoon';
  public static getHighestRatedAnimeAPI     = AdminConfig.sourceAPI + 'getHighestRatedAnime';

 

  // Upload     
  public static generalUploadAPI            = AdminConfig.sourceAPI + 'uploadfile'; 
}
