<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Rating;
use App\Repository\RatingRepository;
use App\Request\CreateRatingRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;
// use App\Request\UpdateRatingRequest;
// use App\Response\UpdateRatingResponse;
use App\Request\GetByIdRequest;

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

        $this->entityManager->persist($ratingEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        
        return $ratingEntity;
    }



    public function update(UpdateCommentRequest $request)
    {
        $commentEntity = $this->commentRepository->find($request->getId());
        
        if (!$commentEntity) {

        } else {
            $commentEntity = $this->autoMapping->mapToObject(UpdateCommentRequest::class, Comment::class, $request, $commentEntity);
            $this->entityManager->flush();
        }
        return $commentEntity;
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
}