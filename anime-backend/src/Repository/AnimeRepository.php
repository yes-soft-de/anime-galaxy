<?php

namespace App\Repository;

use App\Entity\Anime;
use App\Entity\Rating;
use App\Entity\Category;
use App\Entity\Comment;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\Favourite;

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
    
        ->select('anime.id','anime.name', 'anime.mainImage','category.name as categoryName',
            'avg(rate.rateValue) as rating')
        
            ->leftJoin(
                Category::class,
                'category',
                Join::WITH,
                'category.id = anime.categoryID'
            )

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
        return $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name', 'anime.mainImage', 'category.name as categoryName',
                'avg(rate.rateValue) as rating',
                'count(DISTINCT comment.id) as comments')
            ->leftJoin(
                Category::class,
                'category',
                Join::WITH,
                'category.id = anime.categoryID'
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
            )
            ->groupBy('anime.id')
            ->getQuery()
            ->getResult();
    }
    
    public function getAnimeByCategoryID($categoryID)
    {
        return $this->createQueryBuilder('anime')
            ->select('anime.id','anime.name', 'anime.mainImage', 'count(DISTINCT comment.id) as comments','avg(rate.rateValue) as rating')
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
            ->andWhere('anime.categoryID=:categoryID')
            ->groupBy('anime.id')
            ->setParameter('categoryID', (INT)$categoryID)
            ->getQuery()
            ->getResult();
    }

    public function getHighestRatedAnime()
    {
        return $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name as animeName', 'anime.mainImage as animeMainImage', 'category.name as categoryName', 'avg(rate.rateValue) as rating'
                )
            ->leftjoin(
                Category::class,
                'category',
                Join::WITH,
                'category.id = anime.categoryID'
            )
            ->leftJoin(
                Rating::class,
                'rate',
                Join::WITH,
                'rate.animeID = anime.id'
            )
            ->setMaxResults(5)   
            ->addOrderBy('rating','DESC')
            ->groupBy('category.name')
            ->groupBy('animeName')
            ->getQuery()
            ->getResult();
    }

    public function getHighestRatedAnimeByUser($userID)
    {
        return $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name as animeName', 'anime.mainImage as animeMainImage', 'avg(rate.rateValue) as rating')
        ->addSelect('category.name as categoryName')
       
        ->leftJoin(
            Favourite::class,
            'favourite',
            Join::WITH,
           'favourite.userID = :userID'
        )
        ->leftjoin(
            Category::class,
            'category',
            Join::WITH,
            'category.id = anime.categoryID'
        )
         ->leftJoin(
            Rating::class,
            'rate',
            Join::WITH,
            'rate.animeID = anime.id'
        )
        ->andWhere('anime.id=favourite.animeID')
        ->setMaxResults(5)   
        ->addOrderBy('rating','DESC')
        ->setParameter('userID', $userID)
        ->groupBy('anime.id')
        ->getQuery()
        ->getResult();
    }
      
     
}
