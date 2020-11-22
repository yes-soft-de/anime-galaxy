<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Favourite;
use App\Manager\FavouriteManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateFavouriteResponse;
use App\Response\GetFavouriteByIdResponse;
use App\Response\GetFavouriteResponse;
use App\Response\UpdateFavouriteResponse;
use App\Response\GetNotifacationsResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class FavouriteService
{
    private $favouriteManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;
    private $params;

    public function __construct(FavouriteManager $favouriteManager, AutoMapping $autoMapping,
                                GradeService $gradeService, UpdateGradeRequest $updateGradeRequest, ParameterBagInterface $params)
    {
        $this->favouriteManager = $favouriteManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;

        $this->params = $params->get('upload_base_url') . '/';
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
            $row['mainImage'] = $this->specialLinkCheck($row['specialLink']).$row['mainImage'];
            
            $response[] = $this->autoMapping->map("array", GetFavouriteResponse::class, $row);
        }

        return $response;
    }

    public function getFollowersFavourites($friendID)
    {
        return  $this->favouriteManager->getFollowersFavourites($friendID); 
    
    }

    public function delete($animeID, $userID)
    {
        $favouriteResult = $this->favouriteManager->delete($animeID, $userID);

        if ($favouriteResult == null)
        {
            return null;
        }

        return $this->autoMapping->map(Favourite::class, GetFavouriteByIdResponse::class, $favouriteResult);
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool) {
            return $this->params;
        }
    }

    public function notifacations($userID)
    {
        $result = $this->favouriteManager->notifacations($userID);
        $response = [];

        foreach ($result as $row)
        {
            $row['mainImage'] = $this->specialLinkCheck($row['specialLink']).$row['mainImage'];
            
            $response[] = $this->autoMapping->map("array", GetNotifacationsResponse::class, $row);
        }

        return $response;
    }
}