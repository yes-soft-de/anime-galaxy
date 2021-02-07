<?php

namespace App\Repository;

use App\Entity\Anime;
use App\Entity\Rating;
use App\Entity\Category;
use App\Entity\Comment;
use App\Entity\Favourite;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;


/**
 * @method Anime|null find($id, $lockMode = null, $lockVersion = null)
 * @method Anime|null findOneBy(array $criteria, array $orderBy = null)
 * @method Anime[]    findAll()
 * @method Anime[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnimeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Anime::class);
    }

    public function getAnimeById($id)
    {
        return $this->createQueryBuilder('anime')
    
        ->select('anime.id','anime.episodesCount','anime.trailerVideo','anime.name', 'anime.mainImage','anime.description',
            'anime.createdAt','anime.updatedAt','anime.createdBy','anime.updatedBy',
            'anime.categories as cats', 'avg(rate.rateValue) as rating', 'anime.specialLink', 'anime.publishDate', 'anime.generalRating', 'anime.ageGroup', 'anime.posterImage')
        
//            ->leftJoin(
//                Category::class,
//                'category',
//                Join::WITH,
//                'category.id LIKE anime.categoryID'
//            )

            ->leftJoin(
                Rating::class,            
                'rate',                   
                Join::WITH,           
                'rate.animeID = anime.id' 
            )
            ->andWhere('anime.id=:id')
            ->setParameter('id',(INT) $id)

            ->groupBy('anime.id')
            ->orderBy('anime.id')

            ->getQuery()
            ->getResult();
    }

    public function getAll()
    {
        $query = $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name', 'anime.mainImage', 'anime.categories as cats',
                'avg(rate.rateValue) as rating', 'anime.suggest', 'anime.createdAt', 'anime.updatedAt', 'anime.createdBy',
                'anime.updatedBy', 'count(DISTINCT comment.id) as comments', 'anime.specialLink', 'userProfile.userName')

            ->leftJoin(
                UserProfile::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = anime.createdBy'
            )

            ->leftJoin(
                Rating::class,                   
                'rate',                        
                Join::WITH,             
                'rate.animeID = anime.id'  
            )
            ->leftJoin(
                Comment::class,                  
                'comment',                           
                Join::WITH,              
                'comment.animeID = anime.id'      
            );

        return $query->addSelect('userprofile.userName as username2')

            ->leftJoin(
                UserProfile::class,
                'userprofile',
                Join::WITH,
                'userprofile.userID = anime.updatedBy'
            )

            ->groupBy('anime.id')
            ->getQuery()
            ->getResult();
    }
    
    public function getAnimeByCategoryID($categoryID)
    {
        return $this->createQueryBuilder('anime')
            ->select('anime.id','anime.name', 'anime.mainImage', 'count(DISTINCT comment.id) as comments',
                'avg(rate.rateValue) as rating', 'anime.specialLink')
            ->leftJoin(
                Comment::class,            
                'comment',                  
                Join::WITH,          
                'comment.animeID = anime.id ' 
            )
            ->leftJoin(
                Rating::class,            
                'rate',                   
                Join::WITH,           
                'rate.animeID = anime.id' 
            )
            ->andWhere('anime.categories LIKE :categoryID')
            ->groupBy('anime.id')
            ->setParameter('categoryID', '%'.(INT)$categoryID.'%')
            ->getQuery()
            ->getResult();
    }

    /**
     * getHighestRatedAnime depends on the rating, specifically on top 10 rated anime
     */
//    public function getHighestRatedAnime()
//    {
//        return $this->createQueryBuilder('anime')
//            ->select('anime.id', 'anime.name as animeName', 'anime.mainImage as animeMainImage',
//                'category.name as categoryName','category.id as categoryID', 'avg(rate.rateValue) as rating', 'anime.specialLink'
//                )
//            ->leftjoin(
//                Category::class,
//                'category',
//                Join::WITH,
//                'category.id = anime.categoryID'
//            )
//            ->leftJoin(
//                Rating::class,
//                'rate',
//                Join::WITH,
//                'rate.animeID = anime.id'
//            )
//            ->setMaxResults(10)
//            ->addOrderBy('rating','DESC')
//            ->groupBy('categoryID')
//            ->groupBy('anime.id')
//            ->getQuery()
//            ->getResult();
//    }

    public function getHighestRatedAnime()
    {
        return $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name as animeName', 'anime.mainImage as animeMainImage', 'anime.suggest',
                'anime.categories as cats', 'anime.specialLink'
                )
//            ->leftjoin(
//                Category::class,
//                'category',
//                Join::WITH,
//                'category.id = anime.categoryID'
//            )
            ->andWhere('anime.suggest = true')
//            ->groupBy('categoryID')
            ->groupBy('anime.id')
            ->getQuery()
            ->getResult();
    }

    public function getHighestRatedAnimeByUser($userID)
    {
        return $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name as animeName', 'anime.mainImage as animeMainImage',
            'avg(rate.rateValue) as rating', 'anime.specialLink')
        ->addSelect('anime.categories as cats')
       
        ->leftJoin(
            Favourite::class,
            'favourite',
            Join::WITH,
           'favourite.userID = :userID'
        )
//        ->leftjoin(
//            Category::class,
//            'category',
//            Join::WITH,
//            'category.id = anime.categoryID'
//        )
         ->leftJoin(
            Rating::class,
            'rate',
            Join::WITH,
            'rate.animeID = anime.id'
        )
        ->andWhere('anime.id=favourite.animeID')
        ->setMaxResults(10)   
        ->addOrderBy('rating','DESC')
        ->setParameter('userID', $userID)
        ->groupBy('anime.id')
        ->getQuery()
        ->getResult();
    }

    public function getAllComingSoon($date)
    {        
        return $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name', 'anime.mainImage', 'anime.categories as cats',
                'anime.specialLink', 'anime.publishDate', 'anime.posterImage', 'anime.posterSpecialLink')
//            ->leftJoin(
//                Category::class,
//                'category',
//                Join::WITH,
//                'category.id = anime.categoryID'
//            )
            ->andWhere( 'anime.publishDate > :date')
            ->setParameter('date',$date)
            ->groupBy('anime.id')
            ->getQuery()
            ->getResult();       
    }  

    public function getAnimeFavourite($userID)
    {
        return $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name as animeName', 'anime.mainImage as animeMainImage', 'anime.specialLink')
        ->addSelect('anime.categories as cats')
       
        ->join(
            Favourite::class,
            'favourite',
            Join::WITH,
            'favourite.userID = :userID'
        )
//        ->leftjoin(
//            Category::class,
//            'category',
//            Join::WITH,
//            'category.id = anime.categoryID'
//        )
        ->andWhere('anime.id = favourite.animeID')
        ->setParameter('userID', $userID)
        ->groupBy('anime.id')
        ->getQuery()
        ->getResult();
    }

    public function getAnimeByFavouriteCategory($userID)
    {    
        return $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name as animeName', 'anime.mainImage as animeMainImage',
            'avg(rate.rateValue) as rating', 'anime.specialLink')
        ->addSelect('anime.categories as cats')
//        ->leftjoin(
//            Category::class,
//            'category',
//            Join::WITH,
//            'category.id = anime.categoryID'
//        )
        ->join(
            Favourite::class,
            'favourite',
            Join::WITH,
            'favourite.userID = :userID'
        )
        ->leftJoin(
            Rating::class,
            'rate',
            Join::WITH,
            'rate.animeID = anime.id'
        )
        ->andWhere('anime.categories = favourite.categories')
        ->setParameter('userID', $userID)
        ->setMaxResults(10)   
        ->addOrderBy('rating','DESC')
        ->groupBy('anime.id')
        ->getQuery()
        ->getResult();
    }

    public function getAnimeByName($name)
    {
        return $this->createQueryBuilder('anime')

            ->select('anime.id','anime.episodesCount','anime.trailerVideo','anime.name', 'anime.mainImage','anime.description','anime.categories as cats', 'anime.specialLink', 'anime.publishDate', 'anime.generalRating', 'anime.ageGroup')

//            ->leftJoin(
//                Category::class,
//                'category',
//                Join::WITH,
//                'category.id = anime.categoryID'
//            )

            ->andWhere('anime.name LIKE :name')
            ->setParameter('name', '%'.$name.'%')
            ->orderBy('anime.id')

            ->getQuery()
            ->getResult();
    }
}
