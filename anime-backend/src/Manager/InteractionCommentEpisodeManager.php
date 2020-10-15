<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\InteractionCommentEpisode;
use App\Repository\InteractionCommentEpisodeRepository;
use App\Request\CreateInteractionCommentEpisodeRequest;
use App\Request\UpdateInteractionCommentEpisodeRequest;
use Doctrine\ORM\EntityManagerInterface;

class InteractionCommentEpisodeManager
{
    private $entityManager;
    private $interactionRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface,
    InteractionCommentEpisodeRepository $interactionRepository, AutoMapping $autoMapping) {
        $this->entityManager = $entityManagerInterface;
        $this->interactionRepository = $interactionRepository;
        $this->autoMapping = $autoMapping;
    }
    public function create(CreateInteractionCommentEpisodeRequest $request)
    {
        $interactionEntity = $this->autoMapping->map(CreateInteractionCommentEpisodeRequest::class, InteractionCommentEpisode::class, $request);
        $interactionEntity->setCreationDate();

        $this->entityManager->persist($interactionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $interactionEntity;
    }

    public function update(UpdateInteractionCommentEpisodeRequest $request)
    {
        $interaction = $this->interactionRepository->find($request->getId());

        if (!$interaction) {

        } else {
            $interaction = $this->autoMapping->mapToObject(UpdateInteractionCommentEpisodeRequest::class, InteractionCommentEpisode::class, $request, $interaction);
          
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
