<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\InterAction;
use App\Repository\InterActionRepository;
use App\Request\CreateInterActionRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;
use App\Request\UpdateInterActionRequest;
use App\Response\UpdateInterActionResponse;
use App\Request\GetByIdRequest;

class InterActionManager
{
    private $entityManager;
    private $interActionRepository;
    private $autoMapping;   
   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    InterActionRepository $interActionRepository, AutoMapping $autoMapping )
    {
        $this->entityManager          = $entityManagerInterface;
        $this->interActionRepository  = $interActionRepository;
        $this->autoMapping            = $autoMapping;
    }
    public function create(CreateinterActionRequest $request)
    {
        $interActionEntity = $this->autoMapping->map(CreateinterActionRequest::class, InterAction::class, $request);

        $this->entityManager->persist($interActionEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $interActionEntity;
    }



    public function update(InterActionRepository $request)
    {
        $interActionEntity = $this->interActionRepository->find($request->getId());
        
        if (!$interAction) {

        }
        else {
            $interAction = $this->autoMapping->mapToObject(UpdateInterActionRequest::class, InterAction::class, $request, $interActionEntity);
            $this->entityManager->flush();
        }
        return $interAction;
    }


    public function getAll($animeID)
    {
        $interActions = $this->interActionRepository->getAll($animeID);

        return $interActions;
    }


    public function getInterActionwithUser($animeID, $userID)
    {
        $interActions = $this->interActionRepository->getInterActionwithUser($animeID, $userID);

        return $interActions;
    }


    public function countInerActions($animeID)
    {
        $interActions = $this->interActionRepository->countInerActions($animeID);

        return $interActions;
    }
}