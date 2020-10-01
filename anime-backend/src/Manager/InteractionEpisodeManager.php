<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\InteractionEpisode;
use App\Repository\InteractionEpisodeRepository;
use App\Request\CreateInteractionEpisodeRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;
use App\Request\UpdateInteractionEpisodeRequest;
use App\Request\GetByIdRequest;

class InteractionEpisodeManager
{
    private $entityManager;
    private $interactionRepository;
    private $autoMapping;   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    InteractionEpisodeRepository $interactionRepository, AutoMapping $autoMapping )
    {
        $this->entityManager          = $entityManagerInterface;
        $this->interactionRepository  = $interactionRepository;
        $this->autoMapping            = $autoMapping;
    }
    public function create(CreateInteractionEpisodeRequest $request)
    {
        $interactionEntity = $this->autoMapping->map(CreateInteractionEpisodeRequest::class, InteractionEpisode::class, $request);

        $this->entityManager->persist($interactionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $interactionEntity;
    }

    public function update(UpdateInteractionEpisodeRequest $request)
    {
        $interaction = $this->interactionRepository->find($request->getId());
        
        if (!$interaction)
        {

        }
        else
            {
            $interaction = $this->autoMapping->mapToObject(UpdateInteractionEpisodeRequest::class, InteractionEpisode::class, $request, $interaction);
            $this->entityManager->flush();
        }
        return $interaction;
    }

    public function getAll($episode)
    {
        $interactions = $this->interactionRepository->getAll($episode);

        return $interactions;
    }

    public function getInteractionWithUser($episode, $userID)
    {
        $interactions = $this->interactionRepository->getInteractionWithUser($episode, $userID);

        return $interactions;
    }

    public function loved($request)
    {
        return $this->interactionRepository->getAllLove($request->getID());
    }

    public function like($request)
    {
        return $this->interactionRepository->getAllLikes($request->getID());
    }

    public function lovedAll($ID)
    {
        return $this->interactionRepository->getLoveAll($ID);
    }

    public function likeAll($ID)
    {
        return $this->interactionRepository->getLikeAll($ID);
    }
}