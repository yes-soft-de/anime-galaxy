<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Rating;
use App\Manager\RatingManager;
use App\Response\CreateRatingResponse;
// use App\Response\UpdateRatingResponse;
use Symfony\Component\HttpFoundation\Request;
use App\Response\GetRatingsResponse;
use App\Response\CountRatingResponse;

class RatingService

{
    private $ratingManager;
    private $autoMapping;


    public function __construct(RatingManager $ratingManager, AutoMapping $autoMapping)
    {
        $this->ratingManager = $ratingManager;
        $this->autoMapping   = $autoMapping;
    }
  
    public function create($request, $userID, $animeID, $rateValue)
    {  
        $request->setUserId($request->getUserId($userID));
        $request->setAnimeId($request->getAnimeId($animeID));
        $request->setRateValue($request->getRateValue($rateValue));
        $ratingManager = $this->ratingManager->create($request);
        $ratingManager->getUserId($userID);
        $ratingManager->getAnimeId($animeID);
        $ratingManager->getRateValue($rateValue);
        $response = $this->autoMapping->map(Rating::class, CreateRatingResponse::class, $ratingManager);
        
        return $response;
    }


    public function getRating($animeID, $userID)
    {
        $result = $this->ratingManager->getRating($animeID, $userID);
        $response = $this->autoMapping->map('array'::class, CountRatingResponse::class, $result);
        $response->setAvgRating($result);
        return $response;
    }



    public function getAllRatings($animeId)
    {
        $result = $this->ratingManager->getAllRatings($animeId);
        $response =  $this->autoMapping->map('array'::class, CountRatingResponse::class, $result);
        $response->setAvgRating($result);
        return $response;
    }

    
}