<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Rating;
use App\Manager\RatingManager;
use App\Response\CreateRatingResponse;
use App\Response\UpdateRatingResponse;
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
  
    public function create($request)
    {  
        $ratingManager = $this->ratingManager->create($request);
        return $this->autoMapping->map(Rating::class, CreateRatingResponse::class, $ratingManager);
    }

    public function update($request)
    {
        $ratingResult = $this->ratingManager->update($request);
     
        return $this->autoMapping->map(Rating::class, UpdateRatingResponse::class, $ratingResult);   
    }

    public function getRating($animeID, $userID)
    {
        $result = $this->ratingManager->getRating($animeID, $userID);
        $response = $this->autoMapping->map('array', CountRatingResponse::class, $result);
        $response->setAvgRating($result);
        return $response;
    }

    public function getAllRatings($animeId)
    {
        $result = $this->ratingManager->getAllRatings($animeId);
        $response =  $this->autoMapping->map('array', CountRatingResponse::class, $result);
        $response->setAvgRating($result);
        return $response;
    }

}