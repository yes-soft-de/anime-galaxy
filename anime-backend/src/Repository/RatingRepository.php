<?php

namespace App\Repository;

use App\Entity\Rating;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Rating|null find($id, $lockMode = null, $lockVersion = null)
 * @method Rating|null findOneBy(array $criteria, array $orderBy = null)
 * @method Rating[]    findAll()
 * @method Rating[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Rating::class);
    }

    public function getRating($animeID, $userID)
    {
        //avg Rating
        return $this->createQueryBuilder('Rating')
              ->andWhere('Rating.animeID = :animeID')
              ->andWhere('Rating.userID = :userID')
              ->select('sum(Rating.rateValue) / count(Rating.rateValue) as rating')
              ->setParameter('animeID', $animeID)
              ->setParameter('userID', $userID)
              ->getQuery()
              ->getResult();
        
    }

    public function getAllRatings($id)
    {
        //avg Rating
        return $this->createQueryBuilder('Rating')
                ->andWhere('Rating.animeID = :id')
                ->select('avg(Rating.rateValue) as rating')
                ->setParameter('id', $id)
                ->getQuery()
                ->getOneOrNullResult();
    }
}
