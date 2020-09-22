<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Favourite;
use App\Repository\FavouriteRepository;
use App\Request\CreateFavouriteRequest;
use App\Request\UpdateFavouriteRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;

class FavouriteManager
{
    private $entityManager;
    private $favouriteRepository;
    private $autoMapping;   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    FavouriteRepository $favouriteRepository, AutoMapping $autoMapping )
    {
        $this->entityManager      = $entityManagerInterface;
        $this->favouriteRepository  = $favouriteRepository;
        $this->autoMapping        = $autoMapping;
    }

    public function create(CreateFavouriteRequest $request)
    {
        $favouriteEntity = $this->autoMapping->map(CreateFavouriteRequest::class, Favourite::class, $request);

        $this->entityManager->persist($favouriteEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $favouriteEntity;
    }

    public function update(UpdateFavouriteRequest $request)
    {
        $favouriteEntity = $this->favouriteRepository->find($request->getId());
        
        if (!$favouriteEntity)
        {

        }
        else {
            $favouriteEntity = $this->autoMapping->mapToObject(UpdateFavouriteRequest::class, Favourite::class, $request, $favouriteEntity);
            $this->entityManager->flush();
        }
        return $favouriteEntity;
    }

    public function getFavouriteById(GetByIdRequest $request)
    {
        return $result = $this->favouriteRepository->find($request->getId());
    }

    public function getAllFavouritesByAnimeID($animeID)
    {
        $favourite = $this->favouriteRepository->getAllFavouritesByAnimeID($animeID);

        return $favourite;
    }

    public function getAllFavouritesByUserID($userID)
    {
        $favourite = $this->favouriteRepository->getAllFavouritesByUserID($userID);

        return $favourite;
    }
}