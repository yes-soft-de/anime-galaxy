<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\WatchList;
use App\Repository\WatchListRepository;
use App\Request\CreateWatchListRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;
use App\Request\DeleteRequest;
use App\Request\UpdateWatchListRequest;
use App\Response\UpdateWatchListResponse;
use App\Request\GetByIdRequest;

class WatchListManager
{
    private $entityManager;
    private $watchListRepository;
    private $autoMapping;   
   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    WatchListRepository $watchListRepository, AutoMapping $autoMapping )
    {
        $this->entityManager      = $entityManagerInterface;
        $this->watchListRepository  = $watchListRepository;
        $this->autoMapping        = $autoMapping;
    }
    public function create(CreateWatchListRequest $request)
    {
        $watchListEntity = $this->autoMapping->map(CreateWatchListRequest::class, WatchList::class, $request);

        $this->entityManager->persist($watchListEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $watchListEntity;
    }



    public function update(UpdateWatchListRequest $request)
    {
        $watchListEntity = $this->watchListRepository->find($request->getId());
        
        if (!$watchListEntity) {

        } else {
            $watchListEntity = $this->autoMapping->mapToObject(UpdateWatchListRequest::class, WatchList::class, $request, $watchListEntity);
            $this->entityManager->flush();
        }
        return $watchListEntity;
    }

    

    public function getWatchListById(GetByIdRequest $request)
    {
        return $result = $this->watchListRepository->find($request->getId());
    }


    public function getAllWatchListsByAnimeID($animeID)
    {
        $watchLists = $this->watchListRepository->getAllWatchListsByAnimeID($animeID);

        return $watchLists;
    }

    public function getAllWatchListsByUserID($userID)
    {
        $watchLists = $this->watchListRepository->getAllWatchListsByUserID($userID);

        return $watchLists;
    }
}