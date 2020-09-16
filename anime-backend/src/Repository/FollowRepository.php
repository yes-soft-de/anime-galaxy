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
        $res = $this->createQueryBuilder('follow')
            ->getQuery()
            ->getResult();

        return $res;
    }

    public function getFollowById($id): ?Follow
    {
        $res = $this->createQueryBuilder('follow')
            ->andWhere('follow.id=:id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getOneOrNullResult();

        return $res;
    }

    public function getFollowsByUserId($userID)
    {
        $res = $this->createQueryBuilder('follow')
            ->andWhere('follow.userID=:userID')
            ->setParameter('userID',$userID)
            ->getQuery()
            ->getResult();

        return $res;
    }

    public function getFollowByUserIdAndFriendId($userID, $friendID): ?Follow
    {
        $res = $this->createQueryBuilder('follow')
            ->andWhere('follow.userID=:userID')
            ->andWhere('follow.friendID=:friendID')
            ->setParameter('userID',$userID)
            ->setParameter('friendID', $friendID)
            ->getQuery()
            ->getOneOrNullResult();

        return $res;
    }
}
