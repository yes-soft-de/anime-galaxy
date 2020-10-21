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

    public function __construct(FollowManager $followManager, AutoMapping $autoMapping, CommentService $commentService, RatingService $ratingService)
    {
        $this->followManager = $followManager;
        $this->autoMapping = $autoMapping;
        $this->commentService = $commentService;
        $this->ratingService = $ratingService;
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

    // public function searchMyArray($arrays, $key, $search)
    // {
    //     $count = 0;

    //     foreach ($arrays as $object) {
    //         if (is_object($object)) {
    //             $object = get_object_vars($object);
    //         }
    //         if (array_key_exists($key, $object) && $object[$key] == $search) {
    //             $count++;
    //         }

    //     }
    //     return $count;
    // }
    function sortByDate($key)
    {
        return function ($a) use ($key) {
             if ($a[$key] != $a[$key]) {
                return ($a[$key] > $a[$key]) ? -1 : 1;   
            }
             else {
                return 0;
            }
        };

    }
    public function getFollowers($userID)
    {
        /** @var $response */
        $response = [];
        $arr = [];
        $resultFollowers = $this->followManager->getFollowers($userID);

        foreach ($resultFollowers as $row) {

            $row['comment'] = $this->commentService->getFollowersComments($row['friendID']);

            $row['rating'] = $this->ratingService->getFollowersRatings($row['friendID']);

            foreach ($row['comment'] as $res) {

                // if ($this->searchMyArray($row['comment'], 'commentID', true)) {
                    $arr[] = $res;
                    // $response[] = $this->autoMapping->map('array', getFollowersActivitiesResponse::class, $res);
                // }
            }

            foreach ($row['rating'] as $res) {

                // if ($this->searchMyArray($row['rating'], 'RatingID', true)) {
                    $arr[] = $res;
                    // $response[] = $this->autoMapping->map('array', getFollowersActivitiesResponse::class, $res);
                // }
            }          
           
        }
    //    array_multisort(array_column($arr,'Date'),
        // SORT_DESC);
      usort($arr, $this->sortByDate('date'));

         foreach ($arr as $res) {
            $response[] = $this->autoMapping->map('array', getFollowersActivitiesResponse::class, $res);
         }
        dd($response);
        return $response;
    }

}
