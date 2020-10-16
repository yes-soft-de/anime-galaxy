<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\Anime;
use App\Repository\AnimeRepository;
use App\Request\CreateAnimeRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateAnimeRequest;
use Doctrine\ORM\EntityManagerInterface;

class AnimeManager
{
    private $entityManager;
    private $animeRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManager, AnimeRepository $animeRepository,
 AutoMapping $autoMapping)
    {
        $this->entityManager = $entityManager;
        $this->animeRepository = $animeRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateAnimeRequest $request)
    {
        $animeEntity = $this->autoMapping->map(CreateAnimeRequest::class, Anime::class, $request);
        $animeEntity->setCreationDate();
        $this->entityManager->persist($animeEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $animeEntity;
    }

    public function getAnimeById(GetByIdRequest $request)
    {
        return $this->animeRepository->getAnimeById($request->getId());
    }

    public function getAllAnime()
    {
        return $this->animeRepository->getAll();
    }


    public function getByCategoryID($categoryID)
    {
        return $this->animeRepository->getAnimeByCategoryID($categoryID);
    }

    public function update(UpdateAnimeRequest $request)
    {
        $animeEntity = $this->animeRepository->find($request->getId());
        if(!$animeEntity)
        {
            //return null;
        }
        else
        {
            $animeEntity = $this->autoMapping->mapToObject(UpdateAnimeRequest::class,
                Anime::class, $request, $animeEntity);
            $this->entityManager->flush();
            return $animeEntity;
        }
    }

    public function delete(DeleteRequest $request)
    {
        $anime = $this->animeRepository->getAnimeById($request->getId());
        if(!$anime)
        {
            return null;
        }
        else
        {
            $this->entityManager->remove($anime);
            $this->entityManager->flush();
        }
        return $anime;
    }


    public function getHighestRatedAnime()
    {
        return $this->animeRepository->getHighestRatedAnime();
    }

    public function getHighestRatedAnimeByUser($userID)
    {
        return $this->animeRepository->getHighestRatedAnimeByUser($userID);
    }

    public function getAllCommingSoon()
    {
        $date = new \DateTime("Now");
        return $this->animeRepository->getAllCommingSoon($date);
    }

    public function getAnimeFavourite($userID)
    {
        return $this->animeRepository->getAnimeFavourite($userID);
    }
    public function getAnimeByFavouriteCateory($id)
    {
        return $this->animeRepository->getAnimeByFavouriteCateory($id);
    }

}