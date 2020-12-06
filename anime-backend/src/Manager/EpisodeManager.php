<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\Episode;
use App\Repository\EpisodeRepository;
use App\Request\CreateEpisodeRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateEpisodeRequest;
use Doctrine\ORM\EntityManagerInterface;

class EpisodeManager
{
    private $entityManager;
    private $episodeRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManager, AutoMapping $autoMapping,
 EpisodeRepository $episodeRepository)
    {
        $this->entityManager = $entityManager;
        $this->episodeRepository = $episodeRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateEpisodeRequest $request)
    {
        $episodeEntity = $this->autoMapping->map(CreateEpisodeRequest::class, Episode::class, $request);
        $episodeEntity->setCreatedAt();
        $episodeEntity->setDuration($request->getDuration());
        $episodeEntity->setPublishDate($episodeEntity->getPublishDate());

        $this->entityManager->persist($episodeEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $episodeEntity;
    }

    public function update(UpdateEpisodeRequest $request)
    {
        $episodeEntity = $this->episodeRepository->find($request->getId());;
        if(!$episodeEntity)
        {

        }
        else
        {
            $episodeEntity = $this->autoMapping->mapToObject(UpdateEpisodeRequest::class,
             Episode::class, $request, $episodeEntity);

            $episodeEntity->setCreatedAt();
            $episodeEntity->setDuration();
            $episodeEntity->setPublishDate($episodeEntity->getPublishDate());

            $this->entityManager->flush();
            return $episodeEntity;
        }
    }

    public function getEpisodeById(GetByIdRequest $request)
    {
        return $this->episodeRepository->getEpisodeById($request->getId());
    }

    public function getEpisodesByAnimeId($animeId)
    {
        return $this->episodeRepository->getEpisodesByAnimeId($animeId);
    }

    public function getEpisodesByAnimeIdAndSeasonNumber($animeId, $seasonNumber)
    {
        return $result = $this->episodeRepository->getEpisodesByAnimeIdAndSeasonNumber($animeId, $seasonNumber);
    }

    public function delete(DeleteRequest $request)
    {
        $episode = $this->episodeRepository->find($request->getId());
        if(!$episode)
        {
            return null;
        }
        else
        {
            $this->entityManager->remove($episode);
            $this->entityManager->flush();
        }
        return $episode;
    }

    public function getAllComingSoon()
    {
        $date = new \DateTime("Now");
        return $this->episodeRepository->getAllComingSoon($date);
    }
}