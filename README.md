# anime-galaxy

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
`Method: POST. Path: /comment/userID/animeID`
##### Update existing comment by ID. 
`Method: PUT. Path: /comment/userID/animeID`
##### Delete existing comment by ID. 
`Method: DELETE. Path: /comment/ID`
##### Get specific comment by ID. 
`Method: GET. Path: /comment/ID`
##### Get all comments by animeID. 
`Method: GET. Path: /comments/animeID`


### Interaction APIs
##### Create new Interaction. 
`Method: POST. Path: /Interaction/userID/animeID/type`
##### Update existing interaction. 
`Method: PUT. Path: /Interaction/userID/animeID/type`
##### Get all interaction by animeID. 
`Method: GET. Path: /Interaction/animeID`
##### Get all interaction by animeID and userID. 
`Method: GET. Path: /Interaction/animeID/userID`
##### Get count interaction by animeID. Method: GET. Path/ countInteractions/animeID

### Rating APIs
##### Create new rating. 
`Method: POST. Path: /rating/userID/animeID/rateValue`
##### Update existing rating. 
`Method: PUT. Path: /rating/userID/animeID/rateValue`
##### Get rating by animeID and userID. 
`Method: GET. Path: /rating/animeID/userID`
##### Get rating by animeID . 
`Method: GET. Path: /ratings/animeID`

### Watch List APIs
##### Create watchList. 
`Method: POST. Path: /watchList/userID/animeID`
##### Get a watchList  by ID. 
`Method: GET. Path: /watchList/ID`
##### Get a watchList  by animeID. 
`Method: GET. Path: /watchListsAnime/animeID`
##### Get a watchList  by userID. 
`Method: GET. Path: /watchListsUser/userID`
