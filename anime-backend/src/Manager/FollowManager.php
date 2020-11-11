<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\Follow;
use App\Repository\FollowRepository;
use App\Request\CreateFollowRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Doctrine\ORM\EntityManagerInterface;

class FollowManager
{
    private $entityManager;
    private $followRepository;
    private $autoMapping;

    /**
     * FollowManager constructor.
     * @param EntityManagerInterface $entityManager
     * @param FollowRepository $followRepository
     * @param AutoMapping $autoMapping
     */
    public function __construct(EntityManagerInterface $entityManager, FollowRepository $followRepository,
                                AutoMapping $autoMapping)
    {
        $this->entityManager = $entityManager;
        $this->followRepository = $followRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateFollowRequest $request)
    {
        $followEntity = $this->autoMapping->map(CreateFollowRequest::class, Follow::class, $request);
        $this->entityManager->persist($followEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $followEntity;
    }


    public function getAll()
    {
        return $this->followRepository->getAll();
    }

    public function getFollowByUserId($request)
    {
        return $this->followRepository->getFollowsByUserId($request->get('userID'));
    }


    public function delete(DeleteRequest $request)
    {
        $follow = $this->followRepository->getFollowById($request->getId());
        if (!$follow )
        {

        }
        else
        {

            $this->entityManager->remove($follow);
            $this->entityManager->flush();
        }
        return $follow;
    }

    public function deleteByUserIdAndFriendId($request)
    {
        $follow = $this->followRepository->getFollowByUserIdAndFriendId($request->get('userID'),
            $request->get('friendID'));
        if (!$follow )
        {

        }
        else
        {
            $this->entityManager->remove($follow);
            $this->entityManager->flush();
        }
        return $follow;
    }

    public function getFollowers($userID)
    {
        
        return $this->followRepository->getFollowers($userID);
    }

}