<?php

namespace App\Repository;

use App\Entity\RatingEpisode;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method RatingEpisode|null find($id, $lockMode = null, $lockVersion = null)
 * @method RatingEpisode|null findOneBy(array $criteria, array $orderBy = null)
 * @method RatingEpisode[]    findAll()
 * @method RatingEpisode[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingEpisodeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RatingEpisode::class);
    }

    public function getRating($episodeID, $userID)
    {
        //avg Rating
        return $this->createQueryBuilder('RatingEpisode')
              ->andWhere('RatingEpisode.episodeID = :episodeID')
              ->andWhere('RatingEpisode.userID = :userID')
              ->select('sum(RatingEpisode.rateValue) / count(RatingEpisode.rateValue) as rating')
              ->setParameter('episodeID', $episodeID)
              ->setParameter('userID', $userID)
              ->getQuery()
              ->getResult();
        
    }

    public function getAllRatings($episodeID)
    {
        //avg Rating
        return $this->createQueryBuilder('RatingEpisode')
                ->andWhere('RatingEpisode.episodeID = :episodeID')
                ->select('avg(RatingEpisode.rateValue) as rating')
                ->setParameter('episodeID', $episodeID)
                ->getQuery()
                ->getOneOrNullResult();
    }
}
