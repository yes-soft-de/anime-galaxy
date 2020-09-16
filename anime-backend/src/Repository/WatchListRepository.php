<?php

namespace App\Repository;

use App\Entity\WatchList;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method WatchList|null find($id, $lockMode = null, $lockVersion = null)
 * @method WatchList|null findOneBy(array $criteria, array $orderBy = null)
 * @method WatchList[]    findAll()
 * @method WatchList[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class WatchListRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, WatchList::class);
    }

    public function getAllWatchListsByAnimeID($id)
    {
        return  $res= $this->createQueryBuilder('WatchList')
        ->andWhere('WatchList.animeID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getAllWatchListsByUserID($id)
    {
        return  $res= $this->createQueryBuilder('WatchList')
        ->andWhere('WatchList.userID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }
}
