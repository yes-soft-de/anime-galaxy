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
                'count(DISTINCT interAction.type) as countInteraction','avg(rate.rateValue) as rating',
                'count(DISTINCT comment.comment) as comments')
            ->leftJoin(
                Category::class,
                'category',
                Join::WITH,
                'category.id = anime.categoryID'
            )
            ->leftJoin(
                InterAction::class,              //Entity
                'interAction',                        //Alias
                Join::WITH,              //Join Type
                'interAction.animeID = anime.id'  //Join Column
            )
            ->leftJoin(
                Rating::class,                   //Entity
                'rate',                         //Alias
                Join::WITH,              //Join Type
                'rate.animeID = anime.id'   //Join Column
            )
            ->leftJoin(
                Comment::class,                  //Entity
                'comment',                            //Alias
                Join::WITH,              //Join Type
                'comment.animeID = anime.id'      //Join Column
            )
            ->groupBy('anime.id')
            ->getQuery()
            ->getResult();

        return $res;
    }

    public function getAnimeById($id)
    {
        $res = $this->createQueryBuilder('anime')
    
        ->select('anime.id','anime.name', 'anime.id','anime.name', 'anime.mainImage','category.name as categoryName', 'count( DISTINCT interAction.type) as countInteraction', 'avg(rate.rateValue) as rating', 'count(DISTINCT comment.comment) as comments')
        
            ->leftJoin(
                Category::class,            // Entity
                'category',                   // Alias
                Join::WITH,           // Join type
                'category.id = anime.categoryID' // Join columns
            )
            
            ->leftJoin(
            InterAction::class,            // Entity
            'interAction',                   // Alias
            Join::WITH,           // Join type
            'interAction.animeID = anime.id' // Join columns
            )
            ->leftJoin(
                Rating::class,            // Entity
                'rate',                   // Alias
                Join::WITH,           // Join type
                'rate.animeID = anime.id' // Join columns
            )
            ->leftJoin(
                Comment::class,            // Entity
                'comment',                   // Alias
                Join::WITH,          // Join type
                'comment.animeID = anime.id ' // Join columns
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
                'count(DISTINCT interAction.type) as countInteraction', 'avg(rate.rateValue) as rating')
            ->leftJoin(
                Comment::class,            // Entity
                'comment',                   // Alias
                Join::WITH,          // Join type
                'comment.animeID = anime.id ' // Join columns
            )
            ->leftJoin(
                InterAction::class,            // Entity
                'interAction',                   // Alias
                Join::WITH,           // Join type
                'interAction.animeID = anime.id ' // Join columns
            )
            ->leftJoin(
                Rating::class,            // Entity
                'rate',                   // Alias
                Join::WITH,           // Join type
                'rate.animeID = anime.id' // Join columns
            )
            ->groupBy('anime.id')
            ->setParameter('categoryId', (INT)$categoryId)
            ->getQuery()
            ->getResult();
        
        return $res;
    }
    
}
