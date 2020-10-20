<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Rating;
use App\Manager\RatingManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateRatingResponse;
use App\Response\UpdateRatingResponse;
use App\Response\CountRatingResponse;

class RatingService
{
    private $ratingManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    public function __construct(RatingManager $ratingManager, AutoMapping $autoMapping,
GradeService $gradeService, UpdateGradeRequest $updateGradeRequest)
    {
        $this->ratingManager = $ratingManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
    }
  
    public function create($request)
    {  
        $ratingManager = $this->ratingManager->create($request);

        $response = $this->autoMapping->map(Rating::class, CreateRatingResponse::class, $ratingManager);

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

        return $response;
    }

 public function getFollowersRatings($friendID)
    {
       return $this->ratingManager->getFollowersRatings($friendID);
        
    }
}