<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Interaction;
use App\Repository\InteractionRepository;
use App\Request\CreateInteractionRequest;
use App\Request\UpdateInteractionRequest;
use Doctrine\ORM\EntityManagerInterface;

class InteractionManager
{
    private $entityManager;
    private $interactionRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface,
        InteractionRepository $interactionRepository, AutoMapping $autoMapping) {
        $this->entityManager = $entityManagerInterface;
        $this->interactionRepository = $interactionRepository;
        $this->autoMapping = $autoMapping;
    }
    public function create(CreateInteractionRequest $request)
    {
        $interactionEntity = $this->autoMapping->map(CreateInteractionRequest::class, Interaction::class, $request);
        $interactionEntity->setCreationDate();

        $this->entityManager->persist($interactionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $interactionEntity;
    }

    public function update(UpdateInteractionRequest $request)
    {
        $interaction = $this->interactionRepository->find($request->getId());

        if (!$interaction) {

        } else {
            $interaction = $this->autoMapping->mapToObject(UpdateInteractionRequest::class, Interaction::class, $request, $interaction);
            $this->entityManager->flush();
        }
        return $interaction;
    }

    public function getAll($animeID)
    {
        return $this->interactionRepository->getAll($animeID);
    }

    public function getInteractionWithUser($animeID, $userID)
    {
        return $this->interactionRepository->getInteractionWithUser($animeID, $userID);
    }

    public function countInteractions($animeID)
    {
        return $this->interactionRepository->countInteractions($animeID);
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
