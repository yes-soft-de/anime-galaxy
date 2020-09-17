<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\InterAction;
use App\Manager\InterActionManager;
use App\Response\CreateInterActionResponse;
use App\Response\UpdateInterActionResponse;
use Symfony\Component\HttpFoundation\Request;
use App\Response\GetInterActionsResponse;
use App\Response\CountInerActionResponse;

class InterActionService

{
    private $interActionManager;
    private $autoMapping;


    public function __construct(InterActionManager $interActionManager, AutoMapping $autoMapping)
    {
        $this->interActionManager = $interActionManager;
        $this->autoMapping        = $autoMapping;
    }
  
    public function create($request, $userID, $animeID, $type)
    {  
        $request->setUserId($request->getUserId($userID));
        $request->setAnimeId($request->getAnimeId($animeID));
        $request->setType($request->getType($type));
        $interActionManager = $this->interActionManager->create($request);
        $interActionManager->getUserId($userID);
        $interActionManager->getAnimeId($animeID);
        $interActionManager->getType($type);
        $response = $this->autoMapping->map(InterAction::class, CreateInterActionResponse::class, $interActionManager);
            
        return $response;
    }

    public function update($request)
    {
        $interactionResult = $this->interActionManager->update($request);
     
        $response = $this->autoMapping->map(InterAction::class, UpdateInterActionResponse::class, $interactionResult);
        
        return $response;   
    }
    
    
    
    public function getAll($animeID)
    {
        $result = $this->interActionManager->getAll($animeID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(InterAction::class, GetInterActionsResponse::class, $row);
        }

        return $response;
    }


    public function getInterActionwithUser($animeID, $userID)
    {
        $result = $this->interActionManager->getInterActionwithUser($animeID, $userID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(InterAction::class, GetInterActionsResponse::class, $row);
        }

        return $response;
    }

    public function countInerActions($animeId)
    {
        $result = $this->interActionManager->countInerActions($animeId);
        $response =  $this->autoMapping->map('array', CountInerActionResponse::class, $result);
        $response->setCountIneraction($result);
        return $response;
    }
}