<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Interaction;
use App\Manager\InteractionManager;
use App\Request\CreateInteractionRequest;
use App\Response\CreateInteractionResponse;
use App\Response\UpdateInteractionResponse;
use App\Response\GetInteractionResponse;
class InteractionService
{
    private $interactionManager;
    private $autoMapping;

    public function __construct(InteractionManager $interactionManager, AutoMapping $autoMapping)
    {
        $this->interactionManager = $interactionManager;
        $this->autoMapping        = $autoMapping;
    }
  
    public function create(CreateInteractionRequest $request)
    {
        $interactionManager = $this->interactionManager->create($request);

        return $this->autoMapping->map(Interaction::class, CreateInteractionResponse::class, $interactionManager);
    }

    public function update($request)
    {
        $interactionResult = $this->interactionManager->update($request);
     
        return $this->autoMapping->map(Interaction::class, UpdateInteractionResponse::class, $interactionResult);  
    }
    
    public function getAll($animeID)
    {
        $result = $this->interactionManager->getAll($animeID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(Interaction::class, GetInteractionResponse::class, $row);
        }

        return $response;
    }

    public function getInteractionWithUser($animeID, $userID)
    {
        $result = $this->interactionManager->getInteractionWithUser($animeID, $userID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(Interaction::class, GetInteractionResponse::class, $row);
        }

        return $response;
    }

    public function countInteractions($request)
    {
        return $this->interactionManager->countInteractions($request);
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