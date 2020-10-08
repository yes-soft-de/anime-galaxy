<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\InteractionComment;
use App\Manager\InteractionCommentManager;
use App\Request\CreateInteractionCommentRequest;
use App\Response\CreateInteractionCommentResponse;
use App\Response\UpdateInteractionCommentResponse;


class InteractionCommentService
{
    private $interactionManager;
    private $autoMapping;

    public function __construct(InteractionCommentManager $interactionManager, AutoMapping $autoMapping)
    {
        $this->interactionManager = $interactionManager;
        $this->autoMapping = $autoMapping;
    }
  
    
    public function create(CreateInteractionCommentRequest $request)
    {
        $interactionManager = $this->interactionManager->create($request);

        $response = $this->autoMapping->map(InteractionComment::class, CreateInteractionCommentResponse::class, $interactionManager);
        return $response;
    }

   
    public function update($request)
    {
        $interactionResult = $this->interactionManager->update($request);

        return $this->autoMapping->map(InteractionComment::class, UpdateInteractionCommentResponse::class, $interactionResult);
    }
}