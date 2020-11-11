<?php

namespace App\Repository;

use App\Entity\Rating;
use App\Entity\Anime;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

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

    public function getAllRatings($animeID)
    {
        //avg Rating
        return $this->createQueryBuilder('Rating')
                ->andWhere('Rating.animeID = :animeID')
                ->select('avg(Rating.rateValue) as avgRating')
                ->setParameter('animeID', $animeID)
                ->getQuery()
                ->getOneOrNullResult();
    }

    public function getFollowersRatings($friendID, $date)
    {
        return $this->createQueryBuilder('Rating')
            ->select('Rating.userID','Rating.id as RatingID','Rating.rateValue ','Rating.creationDate as date')
            ->addSelect('Anime.id as animeID','Anime.name as AnimeName','UserProfile.userName','UserProfile.image as userImage')

            ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'Rating.animeID = Anime.id '
            )  
            ->leftJoin(
                UserProfile::class,
                'UserProfile',
                 Join::WITH,
                'Rating.userID = UserProfile.userID '
            )  
            ->andWhere('Rating.creationDate in (:date)')
            ->andWhere('Rating.userID = :friendID')          
            ->setParameter('friendID',$friendID)
            ->setParameter('date',$date)
            ->setMaxResults(3) 
            ->addOrderBy('Rating.creationDate','DESC')
            ->getQuery()
            ->getResult();
            
    }
}