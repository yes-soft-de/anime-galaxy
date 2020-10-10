<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\InteractionComment;
use App\Repository\InteractionCommentRepository;
use App\Request\CreateInteractionCommentRequest;
use App\Request\UpdateInteractionCommentRequest;
use Doctrine\ORM\EntityManagerInterface;

class InteractionCommentManager
{
    private $entityManager;
    private $interactionRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface,
    InteractionCommentRepository $interactionRepository, AutoMapping $autoMapping) {
        $this->entityManager = $entityManagerInterface;
        $this->interactionRepository = $interactionRepository;
        $this->autoMapping = $autoMapping;
    }
    public function create(CreateInteractionCommentRequest $request)
    {
        $interactionEntity = $this->autoMapping->map(CreateInteractionCommentRequest::class, InteractionComment::class, $request);
        $interactionEntity->setCreationDate();

        $this->entityManager->persist($interactionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $interactionEntity;
    }

    public function update(UpdateInteractionCommentRequest $request)
    {
        $interaction = $this->interactionRepository->find($request->getId());

        if (!$interaction) {

        } else {
            $interaction = $this->autoMapping->mapToObject(UpdateInteractionCommentRequest::class, InteractionComment::class, $request, $interaction);
          
            $this->entityManager->flush();
        }
        return $interaction;
    }

    public function getAll($commentID)
    {
        return $this->interactionRepository->getAll($commentID);
    }

    public function getInteractionWithUser($commentID, $userID)
    {
        return $this->interactionRepository->getInteractionWithUser($commentID, $userID);
    }

    
    public function loved($request)
    {
        return $this->interactionRepository->getAllLove($request->getID());
    }

    public function like($request)
    {
        return $this->interactionRepository->getAllLikes($request->getID());
    }

    public function dislike($request)
    {
        return $this->interactionRepository->getAllDislike($request->getID());
    }

    public function lovedAll($ID)
    {
        return $this->interactionRepository->getLoveAll($ID);
    }

    public function likeAll($ID)
    {
        return $this->interactionRepository->getLikeAll($ID);
    }

    public function dislikeAll($ID)
    {
        return $this->interactionRepository->dislikeAll($ID);
    }
}
