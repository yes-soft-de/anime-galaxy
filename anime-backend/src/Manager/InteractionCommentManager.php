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

    
}
