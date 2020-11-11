<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Favourite;
use App\Manager\FavouriteManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateFavouriteResponse;
use App\Response\GetFavouriteResponse;
use App\Response\UpdateFavouriteResponse;

class FavouriteService
{
    private $favouriteManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    public function __construct(FavouriteManager $favouriteManager, AutoMapping $autoMapping,
                                GradeService $gradeService, UpdateGradeRequest $updateGradeRequest)
    {
        $this->favouriteManager = $favouriteManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
    }
  
    public function create($request)
    {  
        $favouriteManager = $this->favouriteManager->create($request);

        $response = $this->autoMapping->map(Favourite::class, CreateFavouriteResponse::class,
            $favouriteManager);

        if($response != null)
        {
            $this->updateGradeRequest->setUserID($response->getUserID());
            $this->updateGradeRequest->setRequestSender("favourite");

            $this->gradeService->update($this->updateGradeRequest);
        }

        return $response;
    }

    public function update($request)
    {
        $favouriteResult = $this->favouriteManager->update($request);

        return $this->autoMapping->map(Favourite::class, UpdateFavouriteResponse::class, $favouriteResult);
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
            $response[] = $this->autoMapping->map("array", GetFavouriteResponse::class, $row);
        }

        return $response;
    }

    public function getFollowersFavourites($friendID)
    {
        return  $this->favouriteManager->getFollowersFavourites($friendID); 
    
    }
}