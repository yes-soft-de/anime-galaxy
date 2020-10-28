<?php

namespace App\Repository;

use App\Entity\Favourite;
use App\Entity\Anime;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method Favourite|null find($id, $lockMode = null, $lockVersion = null)
 * @method Favourite|null findOneBy(array $criteria, array $orderBy = null)
 * @method Favourite[]    findAll()
 * @method Favourite[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class FavouriteRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Favourite::class);
    }

    public function getAllFavouritesByAnimeID($animeID)
    {
        return $this->createQueryBuilder('Favourite')
        ->andWhere('Favourite.animeID = :id')
        ->setParameter('id', $animeID)
        ->getQuery()
        ->getResult();
    }

    public function getAllFavouritesByUserID($id)
    {
        return  $this->createQueryBuilder('Favourite')
             ->addSelect('Favourite.id','Favourite.creationDate as date','Favourite.categoryID as categoryID','Favourite.animeID','Anime.name as AnimeName','Anime.mainImage')
             ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'Favourite.animeID = Anime.id'
            )
             ->andWhere('Favourite.userID = :id')
             ->setParameter('id', $id)
             ->getQuery()
             ->getResult();
    }

    public function getFollowersFavourites($friendID, $date)
    {
        return $this->createQueryBuilder('Favourite')
            ->select('Favourite.id as favouriteID','Favourite.userID','Favourite.animeID ','Favourite.categoryID ','Favourite.creationDate as date')
            ->addSelect('Anime.id as animeID','Anime.name as AnimeName','UserProfile.userName')

            ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'Favourite.animeID = Anime.id'
            )
            ->leftJoin(
                UserProfile::class,
                'UserProfile',
                 Join::WITH,
                'Favourite.userID = UserProfile.userID '
            ) 
            ->andWhere('Favourite.creationDate in (:date)')
            ->andWhere('Favourite.userID = :friendID')         
            ->setParameter('friendID',$friendID)
            ->setParameter('date',$date)
            ->setMaxResults(3) 
            ->addOrderBy('Favourite.creationDate','DESC')
            ->getQuery()
            ->getResult();
            
    }
}
