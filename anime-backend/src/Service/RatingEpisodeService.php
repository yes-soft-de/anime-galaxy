<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\RatingEpisode;
use App\Manager\RatingEpisodeManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateRatingEpisodeResponse;
use App\Response\UpdateRatingEpisodeResponse;
use App\Response\CountRatingResponse;

class RatingEpisodeService
{
    private $ratingManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    public function __construct(RatingEpisodeManager $ratingManager, AutoMapping $autoMapping,
                                GradeService $gradeService,
                                UpdateGradeRequest $updateGradeRequest)
    {
        $this->ratingManager = $ratingManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
    }
  
    public function create($request)
    {  
        $ratingManager = $this->ratingManager->create($request);

        $response = $this->autoMapping->map(RatingEpisode::class, CreateRatingEpisodeResponse::class, $ratingManager);

        if($response != null)
        {
            $this->updateGradeRequest->setUserID($response->getUserID());
            $this->updateGradeRequest->setRequestSender("rating");

            $this->gradeService->update($this->updateGradeRequest);
        }

        return $response;
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