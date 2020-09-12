# anime-galaxy

## API Guide

### Comment APIs
#### Create Comment
```
Method: POST. Path: /comment/userID/animeID
```
#### Update Comment
```
Method: PUT. Path: /comment/userID/animeID
```
#### Delete Comment
```
Method: DELET. Path: /comment/ID
```
#### Get Comment By ID
```
Method:GET. Path: /comment/ID
```
#### Get All Comments For Anime
```
Method:GET. Path: /comments/animeID
```


### Interaction APIs

#### Create Interaction
```
Method:POST. Path: /Interaction/userID/animeID/type
```
#### Update interaction
```
Method: PUT. Path: /Interaction/userID/animeID/type
```
#### Get All Interaction With All Users By AnimeID
```
Method: GET. Path: /Interaction/animeID
```

#### Get All InterAction With User By AnimeID And UserID
```
Method: GET. Path/Interaction/animeID/userID
```
#### Count Interactions By AnimeID
```
Method: GET. Path/countInteractions/animeID
```


### Rating APIs

#### Create Rating
```
Method:POST. Path: /rating/userID/animeID/rateValue
```
#### Update Rating
```
Method: PUT. Path: /rating/userID/animeID/rateValue
```
#### Get Rating By AnimeID And UserID
```
Method: GET. Path: /rating/animeID/ userID
```
#### Get All Ratings By AnimeID
```
Method: GET. Path: /ratings/animeID
```


### Watch List APIs

#### Create Watch List
```
Method: POST. Path: /watchList/userID/animeID
```
#### Get Watch List By Id
```
Method: Get a watchList  by ID. Method: GET. Path: /watchList/ID
```
#### Get All Watch Lists By Anime ID
```
Method: GET. Path: /watchListsAnime/animeID
```
#### Get All Watch Lists By User ID
```
Method: GET. Path: /watchListsUser/userID
```
