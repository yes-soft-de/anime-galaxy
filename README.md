# anime-galaxy

## API Guide

### Comment
#### Create Comment
```
/comment/{userID}/{animeID}
methods={"POST"}
```
#### Update Comment
```
/comment/{userID}/{animeID}
methods={"PUT"}
```
#### Delete Comment
```
/comment/{ID}
methods={"DELETE"}
```
#### Get Comment By ID
```
/comment/{ID}
methods={"GET"}
```
#### Get All Comments For Anime
```
/comments/{animeID}
methods={"GET"}
```


### Interaction

#### Create Interaction
```
/interaction/{userID}/{animeID}/{type}
methods={"POST"}
```
#### Update interaction
```
/interaction/{userID}/{animeID}/{type}
methods={"PUT"}
```
#### Get All Interaction With All Users By AnimeID
```
/interaction/{animeID}
methods={"GET"}
```

#### Get All InterAction With User By AnimeID And UserID
```
/interaction/{animeID}/{userID}
methods={"GET"}
```
#### Count Interactions By AnimeID
```
/countInteractions/{animeID}
methods={"GET"}
```


### Rating

#### Create Rating
```
/rating/{userID}/{animeID}/{rateValue}
methods={"POST"}
```
#### Update Rating
```
/rating/{userID}/{animeID}/{rateValue}
methods={"PUT"}
```
#### Get Rating By AnimeID And UserID
```
/rating/{animeID}/{userID}
methods={"GET"}
```

#### Get All Ratings By AnimeID
```
/ratings/{animeID}
methods={"GET"}
```


### Watch List

#### Create Watch List
```
/watchList/{userID}/{animeID}
methods={"POST"}
```
#### Get Watch List By Id
```
/watchList/{ID}
methods={"GET"}
```
#### Get All Watch Lists By Anime ID
```
/watchListsAnime/{animeID}
methods={"GET"}
```
#### Get All Watch Lists By User ID
```
/watchListsUser/{userID}
methods={"GET"}
```
