<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\InteractionEpisode;
use App\Manager\InteractionEpisodeManager;
use App\Request\CreateInteractionEpisodeRequest;
use App\Response\CreateInteractionEpisodeResponse;
use App\Response\UpdateInteractionEpisodeResponse;
use App\Response\GetInteractionEpisodeResponse;

class InteractionEpisodeService
{
    private $interactionManager;
    private $autoMapping;

    public function __construct(InteractionEpisodeManager $interactionManager, AutoMapping $autoMapping)
    {
        $this->interactionManager = $interactionManager;
        $this->autoMapping        = $autoMapping;
    }
  
    public function create(CreateInteractionEpisodeRequest $request)
    {
        $interactionManager = $this->interactionManager->create($request);

        return $this->autoMapping->map(InteractionEpisode::class, CreateInteractionEpisodeResponse::class, $interactionManager);
    }

    public function update($request)
    {
        $interactionResult = $this->interactionManager->update($request);
     
        return $this->autoMapping->map(InteractionEpisode::class, UpdateInteractionEpisodeResponse::class, $interactionResult);  
    }
    
    public function getAll($episodeID)
    {
        $result = $this->interactionManager->getAll($episodeID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(InteractionEpisode::class, GetInteractionEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function getInteractionWithUser($episodeID, $userID)
    {
        $result = $this->interactionManager->getInteractionWithUser($episodeID, $userID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(InteractionEpisode::class, GetInteractionEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function loved($request)
    {
       return $this->interactionManager->loved($request)[1];
    }

    public function like($request)
    {
        return $this->interactionManager->like($request)[1];
    }

    public function lovedAll($ID)
    {
       return  $this->interactionManager->lovedAll($ID)[1];
    }

    public function likeAll($ID)
    {
       return  $this->interactionManager->likeAll($ID)[1];
    }
}