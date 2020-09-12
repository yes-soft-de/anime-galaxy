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
