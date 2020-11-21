<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Favourite;
use App\Repository\FavouriteRepository;
use App\Request\CreateFavouriteRequest;
use App\Request\DeleteRequest;
use App\Request\UpdateFavouriteRequest;
use Doctrine\ORM\EntityManagerInterface;

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
        $favouriteEntity->setCreationDate();

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

    public function getAllFavouritesByAnimeID($animeID)
    {
        return $this->favouriteRepository->getAllFavouritesByAnimeID($animeID);
    }

    public function getAllFavouritesByUserID($userID)
    {
        return $this->favouriteRepository->getAllFavouritesByUserID($userID);
    }

    public function getFollowersFavourites($userID)
    {
        $date = [];
        for ($i = 1; $i <= 7; $i++) {
            $date[] = date('Y-m-d', strtotime('-' . $i . ' day'));
        }

        return $result = $this->favouriteRepository->getFollowersFavourites($userID, $date);
    }

    public function delete($animeID, $userID)
    {
        $favourite = $this->favouriteRepository->getFavouriteByAnimeIdAndUserId($animeID, $userID);

        if(!$favourite)
        {
            return null;
        }
        else
        {
            $this->entityManager->remove($favourite);
            $this->entityManager->flush();
        }

        return $favourite;
    }
}