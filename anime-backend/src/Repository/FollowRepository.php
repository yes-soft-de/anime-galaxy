<?php

namespace App\Repository;

use App\Entity\Follow;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Follow|null find($id, $lockMode = null, $lockVersion = null)
 * @method Follow|null findOneBy(array $criteria, array $orderBy = null)
 * @method Follow[]    findAll()
 * @method Follow[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class FollowRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Follow::class);
    }

    public function getAll()
    {
        return $this->createQueryBuilder('follow')
            ->getQuery()
            ->getResult();
    }

    public function getFollowById($id): ?Follow
    {
        return $this->createQueryBuilder('follow')
            ->andWhere('follow.id=:id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getFollowsByUserId($userID)
    {
        return $this->createQueryBuilder('follow')
            ->andWhere('follow.userID=:userID')
            ->setParameter('userID',$userID)
            ->getQuery()
            ->getResult();
    }

    public function getFollowByUserIdAndFriendId($userID, $friendID): ?Follow
    {
        return $this->createQueryBuilder('follow')
            ->andWhere('follow.userID=:userID')
            ->andWhere('follow.friendID=:friendID')
            ->setParameter('userID',$userID)
            ->setParameter('friendID', $friendID)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
