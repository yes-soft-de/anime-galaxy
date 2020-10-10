<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\InteractionComment;
use App\Manager\InteractionCommentManager;
use App\Request\CreateInteractionCommentRequest;
use App\Response\CreateInteractionCommentResponse;
use App\Response\GetInteractionCommentResponse;
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

    public function getAll($commentID)
    {
        $result = $this->interactionManager->getAll($commentID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(InteractionComment::class, GetInteractionCommentResponse::class, $row);
        }

        return $response;
    }

    public function getInteractionWithUser($commentID, $userID)
    {
        $result = $this->interactionManager->getInteractionWithUser($commentID, $userID);
        $response = [];
        foreach ($result as $row) {
            $response[] = $this->autoMapping->map(InteractionComment::class, GetInteractionCommentResponse::class, $row);
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

    public function dislike($request)
    {
        return $this->interactionManager->dislike($request)[1];
    }

    public function lovedAll($ID)
    {
       return  $this->interactionManager->lovedAll($ID)[1];
    }

    public function likeAll($ID)
    {
       return  $this->interactionManager->likeAll($ID)[1];
    }

    public function dislikeAll($ID)
    {
       return  $this->interactionManager->dislikeAll($ID)[1];
    }
}
