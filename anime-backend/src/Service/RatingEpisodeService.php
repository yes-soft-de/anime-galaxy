<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\RatingEpisode;
use App\Manager\RatingEpisodeManager;
use App\Response\CreateRatingEpisodeResponse;
use App\Response\UpdateRatingEpisodeResponse;
use App\Response\CountRatingResponse;

class RatingEpisodeService
{
    private $ratingManager;
    private $autoMapping;

    public function __construct(RatingEpisodeManager $ratingManager, AutoMapping $autoMapping)
    {
        $this->ratingManager = $ratingManager;
        $this->autoMapping   = $autoMapping;
    }
  
    public function create($request)
    {  
        $ratingManager = $this->ratingManager->create($request);

        return $this->autoMapping->map(RatingEpisode::class, CreateRatingEpisodeResponse::class, $ratingManager);
    }

    public function update($request)
    {
        $ratingResult = $this->ratingManager->update($request);
     
        return $this->autoMapping->map(RatingEpisode::class, UpdateRatingEpisodeResponse::class, $ratingResult);   
    }

    public function getRating($episodeID, $userID)
    {
        $result = $this->ratingManager->getRating($episodeID, $userID);

        $response = $this->autoMapping->map('array', CountRatingResponse::class, $result);
        $response->setAvgRating($result);

        return $response;
    }

    public function getAllRatings($episodeID)
    {
        $result = $this->ratingManager->getAllRatings($episodeID);

        $response =  $this->autoMapping->map('array', CountRatingResponse::class, $result);
        $response->setAvgRating($result);

        return $response;
    }

}