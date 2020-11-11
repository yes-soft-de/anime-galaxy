<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Rating;
use App\Repository\RatingRepository;
use App\Request\CreateRatingRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\UpdateRatingRequest;

class RatingManager
{
    private $entityManager;
    private $ratingRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface,
    RatingRepository $ratingRepository, AutoMapping $autoMapping )
    {
        $this->entityManager    = $entityManagerInterface;
        $this->ratingRepository = $ratingRepository;
        $this->autoMapping      = $autoMapping;
    }
    public function create(CreateRatingRequest $request)
    {
        $ratingEntity = $this->autoMapping->map(CreateRatingRequest::class, Rating::class, $request);
        $ratingEntity->setCreationDate();

        $this->entityManager->persist($ratingEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        
        return $ratingEntity;
    }



    public function update(UpdateRatingRequest $request)
    {
        $ratingEntity = $this->ratingRepository->find($request->getId());
        
        if (!$ratingEntity) {

        } else {
            $ratingEntity = $this->autoMapping->mapToObject(UpdateRatingRequest::class, Rating::class, $request, $ratingEntity);
            $this->entityManager->flush();
        }
        return $ratingEntity;
    }

    public function getRating($animeID, $userID)
    {
        $rating = $this->ratingRepository->getRating($animeID, $userID);

        return $rating;
    }

    public function getAllRatings($animeID)
    {
        $ratings = $this->ratingRepository->getAllRatings($animeID);

        return $ratings;
    }

    public function getFollowersRatings($friendID)
    {
        $date = [];
        for ($i = 1; $i <= 7; $i++) {
            $date[] = date('Y-m-d', strtotime('-' . $i . ' day'));
        }
        return $result = $this->ratingRepository->getFollowersRatings($friendID, $date);
    }
}