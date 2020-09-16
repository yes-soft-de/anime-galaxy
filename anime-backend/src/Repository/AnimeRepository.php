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

    // /**
    //  * @return Anime[] Returns an array of Anime objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('a.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Anime
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    public function getAll()
    {
        $res = $this->createQueryBuilder('anime')
            ->select('anime.id', 'anime.name', 'img.image as mainImage', 'cat.name as categoryName',
                'count(DISTINCT inter.type) as countInteraction','avg(rate.rateValue) as rating',
                'count(DISTINCT c.comment) as comments')
            ->leftJoin(
                Category::class,
                'cat',
                Join::WITH,
                'cat.id = anime.categoryID'
            )
            ->leftJoin(
                Image::class,                    //Entity
                'img',                          //Alias
                Join::WITH,              //Join Type
                'img.animeID = anime.id'    //Join Column
            )
            ->leftJoin(
                InterAction::class,              //Entity
                'inter',                        //Alias
                Join::WITH,              //Join Type
                'inter.animeID = anime.id'  //Join Column
            )
            ->leftJoin(
                Rating::class,                   //Entity
                'rate',                         //Alias
                Join::WITH,              //Join Type
                'rate.animeID = anime.id'   //Join Column
            )
            ->leftJoin(
                Comment::class,                  //Entity
                'c',                            //Alias
                Join::WITH,              //Join Type
                'c.animeID = anime.id'      //Join Column
            )
            ->groupBy('anime.id')
            ->getQuery()
            ->getResult();

    return $res;
    }

    public function getAnimeById($id)
    {
        $res = $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name', 'count( DISTINCT I.type) as countInteraction', 'avg( R.rateValue) as rating', 'img.image as mainImage', 'c.name as categoryName', 'count(DISTINCT C.comment) as comment')
        
        ->leftJoin(
            InterAction::class,            // Entity
            'I',                   // Alias
            Join::WITH,           // Join type
            'I.animeID = anime.id' // Join columns
        )
        ->leftJoin(
            Rating::class,            // Entity
            'R',                   // Alias
            Join::WITH,           // Join type
            'R.animeID = anime.id' // Join columns
        )
        ->leftJoin(
            image::class,            // Entity
            'img',                   // Alias
            Join::WITH,           // Join type
            'img.animeID = anime.id' // Join columns
        )
        ->join(
            Category::class,            // Entity
            'c',                   // Alias
            Join::WITH,           // Join type
            'c.id = anime.categoryID' // Join columns
        )
        ->leftJoin(
            Comment::class,            // Entity
            'C',                   // Alias
            Join::WITH,          // Join type
            'C.animeID = anime.id ' // Join columns   
        )
        ->andWhere('anime.id=:id')
        ->setParameter('id',$id)
        ->getQuery()
        ->getOneOrNullResult();
        // dd($res); // OK
    return $res;
    }
    
    public function getAnimeByCategoryId($catId)
    {
        $res = $this->createQueryBuilder('anime')
            ->andWhere('anime.categoryID=:catId')
            ->select('anime.id','anime.name', 'count(DISTINCT C.comment) as comment','count(DISTINCT I.type) as countInteraction', 'avg( R.rateValue) as rating', 'img.image as mainImage')
            ->leftJoin(
                Comment::class,            // Entity
                'C',                   // Alias
                Join::WITH,          // Join type
                'C.animeID = anime.id ' // Join columns   
            )
            ->leftJoin(
                InterAction::class,            // Entity
                'I',                   // Alias
                Join::WITH,           // Join type
                'I.animeID = anime.id ' // Join columns
            )
            ->leftJoin(
                Rating::class,            // Entity
                'R',                   // Alias
                Join::WITH,           // Join type
                'R.animeID = anime.id' // Join columns
            )
            ->leftJoin(
                image::class,            // Entity
                'img',                   // Alias
                Join::WITH,           // Join type
                'img.animeID = anime.id' // Join columns
            )
            ->groupBy('anime.id')
            ->setParameter('catId', $catId)
            ->getQuery()
            ->getResult();
        
        return $res;
    }
    
}
