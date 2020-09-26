<?php

namespace App\Repository;

use App\Entity\Anime;
use App\Entity\InterAction;
use App\Entity\Rating;
use App\Entity\Image;
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

    public function getAll()
    {
        $res = $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name', 'anime.mainImage', 'category.name as categoryName',
                'count(DISTINCT interAction.type) as like','avg(rate.rateValue) as rating',
                'count(DISTINCT comment.comment) as comments')
            ->leftJoin(
                Category::class,
                'category',
                Join::WITH,
                'category.id = anime.categoryID'
            )
            ->leftJoin(
                InterAction::class,              
                'interAction',                        
                Join::WITH,              
                'interAction.animeID = anime.id'  
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

        return $res;
    }

    public function getAnimeById($id)
    {
        $res = $this->createQueryBuilder('anime')
    
        ->select('anime.id','anime.name', 'anime.mainImage','category.name as categoryName', 'count( DISTINCT interAction.type) as like', 'avg(rate.rateValue) as rating')
        
            ->leftJoin(
                Category::class,            
                'category',                   
                Join::WITH,           
                'category.id = anime.categoryID'
            )
            
            ->leftJoin(
            InterAction::class,           
            'interAction',                  
            Join::WITH,           
            'interAction.animeID = anime.id' 
            )
            ->leftJoin(
                Rating::class,            
                'rate',                   
                Join::WITH,           
                'rate.animeID = anime.id' 
            )
            ->andWhere('anime.id=:id')
            ->groupBy('anime.id')
            ->orderBy('anime.id')
            ->setParameter('id',(INT) $id)
            ->getQuery()
            ->getResult();

        return $res;
    }
    
    public function getAnimeByCategoryId($categoryId)
    {
        $res = $this->createQueryBuilder('anime')
            ->andWhere('anime.categoryID=:categoryId')
            ->select('anime.id','anime.name', 'anime.mainImage', 'count(DISTINCT comment.comment) as comments',
                'count(DISTINCT interAction.type) as like', 'avg(rate.rateValue) as rating')
            ->leftJoin(
                Comment::class,            
                'comment',                  
                Join::WITH,          
                'comment.animeID = anime.id ' 
            )
            ->leftJoin(
                InterAction::class,           
                'interAction',                  
                Join::WITH,           
                'interAction.animeID = anime.id ' 
            )
            ->leftJoin(
                Rating::class,            
                'rate',                   
                Join::WITH,           
                'rate.animeID = anime.id' 
            )
            ->groupBy('anime.id')
            ->setParameter('categoryId', (INT)$categoryId)
            ->getQuery()
            ->getResult();
        
        return $res;
    }


    public function getHighestRatedAnime()
    {
        $res = $this->createQueryBuilder('anime')
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
            ->setMaxResults(3)   
            ->addOrderBy('rating','DESC')
            ->groupBy('category.name')
            ->groupBy('animeName')
            ->getQuery()
            ->getResult();
        return $res;
    }


    public function getHighestRatedAnimeByUser($userID)
    {
        $res= $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name as animeName', 'anime.mainImage as animeMainImage')
        ->addSelect('category.name as categoryName')
       
        ->leftJoin(
            favourite::class,
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
        ->andWhere('anime.id=favourite.animeID')
        ->setParameter('userID', $userID)
        ->groupBy('anime.id')
        ->getQuery()
        ->getResult();
        return $res;
    }
      
     
}
