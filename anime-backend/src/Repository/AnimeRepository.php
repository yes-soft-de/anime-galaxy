<?php

namespace App\Repository;

use App\Entity\Anime;
use App\Entity\InterAction;
use App\Entity\Rating;
use App\Entity\Image;
use App\Entity\Category;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

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
        ->getQuery()
        ->getResult();

    return $res;
    }

    public function getAnimeById($id)
    {
        $res = $this->createQueryBuilder('anime')
        ->select('anime.id','anime.name', 'count( DISTINCT I.type) as countInteraction', 'avg( R.rateValue) as rating', 'img.image as mainImage', 'c.name as categoryName')
        
        ->leftJoin(
            InterAction::class,            // Entity
            'I',                   // Alias
            Join::WITH,           // Join type
            'I.animeId = anime.id' // Join columns
        )
        ->leftJoin(
            Rating::class,            // Entity
            'R',                   // Alias
            Join::WITH,           // Join type
            'R.animeId = anime.id' // Join columns
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
            ->setParameter('catId', $catId)
            ->getQuery()
            ->getResult();
        
        return $res;
    }
}
