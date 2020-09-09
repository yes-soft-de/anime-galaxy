<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\WatchList;
use App\Manager\WatchListManager;
use App\Response\CreateWatchListResponse;
use App\Response\UpdateWatchListResponse;
use Symfony\Component\HttpFoundation\Request;
use App\Response\GetWatchListByIdResponse;
use App\Response\GetWatchListsResponse;
class WatchListService

{
    private $watchListManager;
    private $autoMapping;


    public function __construct(WatchListManager $watchListManager, AutoMapping $autoMapping)
    {
        $this->watchListManager =$watchListManager;
        $this->autoMapping = $autoMapping;
    }
  
    public function create($request, $userId, $animeId)
    {  
        $request->setUserId($request->getUserId($userId));
        $request->setAnimeId($request->getAnimeId($animeId));
        $watchListManager = $this->watchListManager->create($request);
        $watchListManager->getUserId($userId);
        $watchListManager->getAnimeId($animeId);
        $response = $this->autoMapping->map(WatchList::class, CreatewatchListResponse::class,
            $watchListManager);
            
        return $response;
    }

    public function update($request)
    {
        $watchListResult = $this->watchListManager->update($request);
     
        $response = $this->autoMapping->map(WatchList::class, UpdateWatchListResponse::class, $watchListResult);
        
        return $response;   
    }

    public function delete($request)
    {
        $result = $this->watchListManager->delete($request);
        $response = $this->autoMapping->map(WatchList::class, GetWatchListByIdResponse::class, $result);
    
        if(!$response){
           $error=['error'=>" not found!!!"];
           return $error;
        }
        else{
        return $response;}
          
    }

    public function getWatchListById($request)
    {
        $result = $this->watchListManager->getWatchListById($request);
        $response = $this->autoMapping->map(WatchList::class, GetWatchListByIdResponse::class, $result);
        return $response;
    }


    public function getAllWatchListsByAnimeID($animeID)
    {
        $result = $this->watchListManager->getAllWatchListsByAnimeID($animeID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(WatchList::class, GetWatchListsResponse::class, $row);
        }

        return $response;
    }

    public function getAllWatchListsByUserID($userID)
    {
        $result = $this->watchListManager->getAllWatchListsByUserID($userID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(WatchList::class, GetWatchListsResponse::class, $row);
        }

        return $response;
    }
}