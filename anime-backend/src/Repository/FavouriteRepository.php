<?php

namespace App\Repository;

use App\Entity\Favourite;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

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

    public function getAllFavouritesByAnimeID($id)
    {
        return  $res= $this->createQueryBuilder('Favourite')
        ->andWhere('Favourite.animeID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getAllFavouritesByUserID($id)
    {
        return  $res= $this->createQueryBuilder('Favourite')
        ->andWhere('Favourite.userID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }
}
