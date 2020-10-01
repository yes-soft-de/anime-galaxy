<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\RatingEpisode;
use App\Repository\RatingEpisodeRepository;
use App\Request\CreateRatingEpisodeRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\UpdateRatingEpisodeRequest;

class RatingEpisodeManager
{
    private $entityManager;
    private $ratingRepository;
    private $autoMapping;   
   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    RatingEpisodeRepository $ratingRepository, AutoMapping $autoMapping )
    {
        $this->entityManager    = $entityManagerInterface;
        $this->ratingRepository = $ratingRepository;
        $this->autoMapping      = $autoMapping;
    }
    public function create(CreateRatingEpisodeRequest $request)
    {
        $ratingEntity = $this->autoMapping->map(CreateRatingEpisodeRequest::class, RatingEpisode::class, $request);
        $ratingEntity->setCreationDate();
        $this->entityManager->persist($ratingEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        
        return $ratingEntity;
    }



    public function update(UpdateRatingEpisodeRequest $request)
    {
        $ratingEntity = $this->ratingRepository->find($request->getId());
        
        if (!$ratingEntity) {

        } else {
            $ratingEntity = $this->autoMapping->mapToObject(UpdateRatingEpisodeRequest::class, RatingEpisode::class, $request, $ratingEntity);
            $this->entityManager->flush();
        }
        return $ratingEntity;
    }

    public function getRating($animeID, $userID)
    {
        $rating = $this->ratingRepository->getRating($animeID, $userID);

        return $rating;
    }

    public function getAllRatings($episodeID)
    {
        $ratings = $this->ratingRepository->getAllRatings($episodeID);

        return $ratings;
    }
}