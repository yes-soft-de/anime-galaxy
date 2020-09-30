<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Episode;
use App\Manager\EpisodeManager;
use App\Request\CreateEpisodeRequest;
use App\Response\CreateEpisodeResponse;
use App\Response\GetEpisodeByIdResponse;
use App\Response\GetEpisodeResponse;
use App\Response\UpdateEpisodeResponse;

class EpisodeService
{
    private $episodeManager;
    private $autoMapping;

    public function __construct(EpisodeManager $episodeManager, AutoMapping $autoMapping)
    {
        $this->episodeManager = $episodeManager;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateEpisodeRequest $request)
    {
        $episodeResult = $this->episodeManager->create($request);
        return $this->autoMapping->map(Episode::class, CreateEpisodeResponse::class, $episodeResult);
    }

    public function update($request)
    {
        $episodeResult = $this->episodeManager->update($request);
        $response = $this->autoMapping->map(Episode::class, UpdateEpisodeResponse::class, $episodeResult);

        $response->setDescription($request->getDescription());
        $response->setImage($request->getImage());

        return $response;
    }

    public function getEpisodesByAnimeId($animeID)
    {
        $response = [];
        $result = $this->episodeManager->getEpisodesByAnimeId($animeID);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Episode::class, GetEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber)
    {
        $response = [];
        $result = $this->episodeManager->getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Episode::class, GetEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function getEpisodeById($request)
    {
        $result = $this->episodeManager->getEpisodeById($request);

        return $this->autoMapping->map(Episode::class, GetEpisodeByIdResponse::class, $result);
    }

    public function delete($request)
    {
        $response = [];
        $episodeResult = $this->episodeManager->delete($request);

        if($episodeResult == null)
        {
            return null;
        }

        $response = $this->autoMapping->map(Episode::class, GetEpisodeByIdResponse::class, $episodeResult);

        return $response;
    }
}