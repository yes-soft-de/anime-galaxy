<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Follow;
use App\Manager\FollowManager;
use App\Response\CreateFollowResponse;
use App\Response\GetFollowByIdResponse;
use App\Response\GetFollowResponse;

class FollowService
{
    private $followManager;
    private $autoMapping;


    public function __construct(FollowManager $followManager, AutoMapping $autoMapping)
    {
        $this->followManager = $followManager;
        $this->autoMapping = $autoMapping;
    }

    public function create($request)
    {
        $followResult = $this->followManager->create($request);
        $response = $this->autoMapping->map(Follow::class, CreateFollowResponse::class,
            $followResult);
        return $response;
    }


    public function getAll()
    {
        $result = $this->followManager->getAll();
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Follow::class, GetFollowResponse::class, $row);
        }
        return $response;
    }


    public function getFollowByUserId($request)
    {
        $result = $this->followManager->getFollowByUserId($request);
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Follow::class, GetFollowResponse::class, $row);
        }
        return $response;
    }


    public function delete($request)
    {
        $result = $this->followManager->delete($request);
        $response = $this->autoMapping->map(Follow::class, GetFollowByIdResponse::class, $result);

        if(!$response){
            $error=['error'=>"this category not found!!!"];
            return $error;
        }
        else{
            return $response;
        }


    }

    public function deleteByUserIdAndFriendID($request)
    {
        $result = $this->followManager->deleteByUserIdAndFriendId($request);
        $response = $this->autoMapping->map(Follow::class, GetFollowByIdResponse::class, $result);

        if(!$response){
            $error=['error'=>"this category not found!!!"];
            return $error;
        }
        else{
            return $response;
        }


    }
}