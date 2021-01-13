<?php

namespace App\Repository;

use App\Entity\Favourite;
use App\Entity\Anime;
use App\Entity\Category;
use App\Entity\UserProfile;
use App\Entity\Episode;
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
             ->addSelect('Favourite.id','Favourite.creationDate as date','Favourite.categories as cats','Favourite.animeID',
                 'Anime.name as AnimeName','Anime.mainImage', 'Anime.specialLink')
             ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'Favourite.animeID = Anime.id'
            )
//             ->leftJoin(
//                Category::class,
//                'category',
//                 Join::WITH,
//                'Favourite.categoryID = category.id'
//            )
             ->andWhere('Favourite.userID = :id')
             ->setParameter('id', $id)
             ->getQuery()
             ->getResult();
    }

    public function getFollowersFavourites($friendID, $date)
    {
        return $this->createQueryBuilder('Favourite')
            ->select('Favourite.id as favouriteID','Favourite.userID','Favourite.animeID ','Favourite.categories','Favourite.creationDate as date')
            ->addSelect('Anime.id as animeID','Anime.name as AnimeName','UserProfile.userName','UserProfile.image as userImage')

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

    public function getFavouriteByAnimeIdAndUserId($animeID, $userID): ?Favourite
    {
        return $this->createQueryBuilder('Favourite')
            ->andWhere('Favourite.animeID = :animeID')
            ->andWhere('Favourite.userID = :userID')
            ->setParameter('animeID', $animeID)
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function notifacations($id, $date)
    {
        
        return  $this->createQueryBuilder('Favourite')
             ->addSelect('Favourite.id','Favourite.creationDate as date','Favourite.categories as cats','Favourite.animeID',
                 'Anime.name as AnimeName','Anime.mainImage', 'Anime.specialLink', 'episode.id as episodeID','episode.publishDate')
             ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'Favourite.animeID = Anime.id'
            )
//             ->leftJoin(
//                Category::class,
//                'category',
//                 Join::WITH,
//                'Favourite.categoryID = category.id'
//            )
             ->leftJoin(
                Episode::class,
                'episode',
                 Join::WITH,
                'Favourite.animeID = episode.animeID'
            )
             ->andWhere('Favourite.userID = :id')
             ->andWhere('episode.publishDate in (:date)')
             ->setParameter('id', $id)
             ->setParameter('date',$date)
             ->getQuery()
             ->getResult();
    }
}
