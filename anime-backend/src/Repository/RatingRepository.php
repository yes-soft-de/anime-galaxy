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

    // /**
    //  * @return Rating[] Returns an array of Rating objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('r.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Rating
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */



    public function getRating($animeID, $userID)
    {
        //avg Rating
         $res= $this->createQueryBuilder('Rating')
        ->andWhere('Rating.animeId = :animeID')
        ->andWhere('Rating.userId = :userID')
        ->select('sum(Rating.rateValue) / count(Rating.rateValue) as rating')
        ->setParameter('animeID', $animeID)
        ->setParameter('userID', $userID)
        ->getQuery()
        ->getResult();
        
        return $res;
    }



    public function getAllRatings($id)
    {
        //avg Rating
         $res= $this->createQueryBuilder('Rating')
        ->andWhere('Rating.animeId = :id')
        ->select('sum(Rating.rateValue) / count(Rating.rateValue) as rating')
        ->setParameter('id', $id)
        ->getQuery()
        ->getOneOrNullResult();
        
        return $res;
    }
}
