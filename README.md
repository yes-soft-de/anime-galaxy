# anime-galaxy

##### Table of Contents
* [Anime APIs](#anime-apis)
* [Episode APIs](#episode-apis)
* [Category APIs](#category-apis)
* [Image APIs](#image-apis)
* [Follow APIS](#follow-apis)
* [Comment APIs](#comment-apis)
* [Interaction APIs](#interaction-apis)
* [Rating APIs](#rating-apis)
* [Favourite APIs](#favourite-apis) 
* [Grade APIs](#grade-apis)
* [Comment Episode APIs](#comment-episode-apis)

Comment Episode APIs


### Anime APIs
##### Create new anime.
`Method: POST. Path: /anime`
##### Update existing anime by ID. 
`Method: PUT. Path: /anime`
##### Get specific anime by ID. 
`Method: GET. Path: /anime/ID`
##### Get all anime. 
`Method: GET. Path: /anime`
##### Get all anime of specific category. 
`Method: GET. Path: /category/ID`
##### Delete existing anime by ID. 
`Method: DELET. Path: /anime`
##### Get Highest Rated Anime
`Method: GET. Path: /getHighestRatedAnime`
##### Get Highest Rated Anime By User
`Method: GET. Path: /getHighestRatedAnime/{userID}`

### Episode APIs
##### Insert new episode.
`Method: POST. Path: /episode.`
##### Get an episode by ID.
`Method: Get. Path: /episode/id.`
##### Get episodes of specific anime.
`Method: Get. Path: /episode/animeID.`
##### Get episodes of specific anime and specific season.
`Method: Get. Path: /episode/animeID/seasonNumber.`
##### Update an existing episode by ID.
`Method: PUT. Path: /episode.`
##### Delete an existing episode by ID.
`Method: DELETE. Path: /episode/id.`

### Category APIs
##### Create a new category. 
`Method: POST. Path: /category`
##### Get all categories. 
`Method: GET. Path: /category`
##### Update existing category. 
`Method: PUT. Path: / category`
##### Delete specific category. 
`Method: DELETE. Path: / category`

### Image APIs
##### Insert new image. 
`Method: POST. Path: /image`
##### Update specific image. 
`Method: PUT. Path: /image`
##### Get specific images by animeID. 
`Method: GET. Path: /image/animeID`
##### Delete an existing image by ID. 
`Method: DELETE. Path: / image`


### Follow APIs
##### Add new following. 
`Method: POST. Path: /following`
##### Get a following by userID and friendID. 
`Method: GET. Path: /following/userID/friendID`
##### Get all followings. 
`Method: GET. Path: /following`
##### Delete an existing following by ID.
`Method: DELETE. Path: /following/ID`
##### Delete an existing following by userID and friendID.
`Method: DELETE. Path: /following/userID/friendID`

### Comment APIs
##### Create new comment. 
`Method: POST. Path: /comment`
##### Update existing comment by ID. 
`Method: PUT. Path: /comment`
##### Delete existing comment by ID. 
`Method: DELETE. Path: /comment/ID`
##### Get specific comment by ID. 
`Method: GET. Path: /comment/ID`
##### Get all comments by animeID. 
`Method: GET. Path: /comments/animeID`


### Interaction APIs
##### Create new Interaction. 
`Method: POST. Path: /interaction`
##### Update existing interaction. 
`Method: PUT. Path: /interaction/userID/animeID/type`
##### Get all interaction by animeID. 
`Method: GET. Path: /interaction/animeID`
##### Get all interaction by animeID and userID. 
`Method: GET. Path: /interaction/animeID/userID`
##### Get count interaction by animeID. 
`Method: GET. Path/ countInteractions/animeID`

### Rating APIs
##### Create new rating. 
`Method: POST. Path: /rating`
##### Update existing rating. 
`Method: PUT. Path: /rating`
##### Get rating by animeID and userID. 
`Method: GET. Path: /rating/animeID/userID`
##### Get rating by animeID . 
`Method: GET. Path: /ratings/animeID`

### Favourite APIs
##### Create a new favourite. 
`Method: POST. Path: /favourite`
##### Get a favourite by animeID. 
`Method: GET. Path: /favouriteAnime/{animeID}`
##### Get a favourite by userID. 
`Method: GET. Path: /favouriteUser/userID`

### Grade APIs
##### Create a new recorde with grade equals to 0. 
`Method: POST. Path: /register-point`
##### Update an existing grade by userID. 
`Method: PUT. Path: /grade`
##### Get top 50 users 
###### _Used for display the grade of each user in his/her profile_
`Method: GET. Path: /top50`
##### Get a grade of specific user. 
`Method: GET. Path: /grade/{userID}`
#### Delete an existing recorde by ID. 
`Method: DELETE. Path: /grade/{userID}`

### Comment Episode APIs
##### Create new comment Episode. 
`Method: POST. Path: /commentEpisode`
##### update Comment Episode. 
`Method: PUT. Path: /commentEpisode`
##### Delete existing comment Episode by ID. 
`Method: DELETE. Path: /commentEpisode/ID`
##### Get specific comment by ID. 
`Method: GET. Path: /commentEpisode/ID`
##### Get all comments by episodeID. 
`Method: GET. Path: /commentsEpisode/{episodeID}`
