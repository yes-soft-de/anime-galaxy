<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\Follow;
use App\Manager\FollowManager;
use App\Response\CreateFollowResponse;
use App\Response\GetFollowByIdResponse;
use App\Response\getFollowersActivitiesResponse;
use App\Response\GetFollowResponse;

class FollowService
{
    private $followManager;
    private $autoMapping;
    private $commentService;
    private $ratingService;
    private $favouriteService;

    public function __construct(FollowManager $followManager, AutoMapping $autoMapping, CommentService $commentService, RatingService $ratingService, FavouriteService $favouriteService)
    {
        $this->followManager = $followManager;
        $this->autoMapping = $autoMapping;
        $this->commentService = $commentService;
        $this->ratingService = $ratingService;
        $this->favouriteService = $favouriteService;
    }

    public function create($request)
    {
        $followResult = $this->followManager->create($request);

        return $this->autoMapping->map(Follow::class, CreateFollowResponse::class,
            $followResult);
    }

    public function getAll()
    {
        $result = $this->followManager->getAll();
        $response = [];

        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(Follow::class, GetFollowResponse::class, $row);
        }

        return $response;
    }

    public function getFollowByUserId($request)
    {
        $result = $this->followManager->getFollowByUserId($request);
        $response = [];

        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(Follow::class, GetFollowResponse::class, $row);
        }

        return $response;
    }

    public function delete($request)
    {
        $result = $this->followManager->delete($request);
        $response = $this->autoMapping->map(Follow::class, GetFollowByIdResponse::class, $result);

        if (!$response) {
            return null;
        } else {
            return $response;
        }
    }

    public function deleteByUserIdAndFriendID($request)
    {
        $result = $this->followManager->deleteByUserIdAndFriendId($request);
        $response = $this->autoMapping->map(Follow::class, GetFollowByIdResponse::class, $result);

        if (!$response) {
            return null;
        } else {
            return $response;
        }
    }

    public function getFollowers($userID)
    {
        /** @var $response */
        /** @var $arr */
        $response = [];
        $arr = [];
        $resultFollowers = $this->followManager->getFollowers($userID);

        foreach ($resultFollowers as $row) {

            $row['comment'] = $this->commentService->getFollowersComments($row['friendID']);

            $row['rating'] = $this->ratingService->getFollowersRatings($row['friendID']);
           
            $row['favourite'] = $this->favouriteService->getFollowersFavourites($row['friendID']);

            foreach ($row['comment'] as $res) {

                    $arr[] = $res;
            }

            foreach ($row['rating'] as $res) {

                    $arr[] = $res;
            }

            foreach ($row['favourite'] as $res) {

                    $arr[] = $res;
            }          
           
        }
    
         foreach ($arr as $res) {
            $response[] = $this->autoMapping->map('array', getFollowersActivitiesResponse::class, $res);
            
         } 
         array_multisort(array_column($response,'Date'),SORT_DESC);
        
        // dd($response);
        return $response;
    }

}
