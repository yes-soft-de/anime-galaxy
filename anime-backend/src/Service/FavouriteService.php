<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Favourite;
use App\Manager\FavouriteManager;
use App\Response\CreateFavouriteResponse;
use App\Response\GetFavouriteByIdResponse;
use App\Response\GetFavouriteResponse;
use App\Response\UpdateFavouriteResponse;

class FavouriteService

{
    private $favouriteManager;
    private $autoMapping;


    public function __construct(FavouriteManager $favouriteManager, AutoMapping $autoMapping)
    {
        $this->favouriteManager = $favouriteManager;
        $this->autoMapping = $autoMapping;
    }
  
    public function create($request)
    {  
        $favouriteManager = $this->favouriteManager->create($request);
        $response = $this->autoMapping->map(Favourite::class, CreateFavouriteResponse::class,
            $favouriteManager);
            
        return $response;
    }

    public function update($request)
    {
        $favouriteResult = $this->favouriteManager->update($request);
        $response = $this->autoMapping->map(Favourite::class, UpdateFavouriteResponse::class, $favouriteResult);
        return $response;   
    }

    public function getAllFavouritesByAnimeID($animeID)
    {
        $result = $this->favouriteManager->getAllFavouritesByAnimeID($animeID);
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Favourite::class, GetFavouriteResponse::class, $row);
        }
        return $response;
    }

    public function getAllFavouritesByUserID($userID)
    {
        $result = $this->favouriteManager->getAllFavouritesByUserID($userID);
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Favourite::class, GetFavouriteResponse::class, $row);
        }
        return $response;
    }

}