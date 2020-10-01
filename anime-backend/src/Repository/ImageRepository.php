<?php

namespace App\Repository;

use App\Entity\Image;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Image|null find($id, $lockMode = null, $lockVersion = null)
 * @method Image|null findOneBy(array $criteria, array $orderBy = null)
 * @method Image[]    findAll()
 * @method Image[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ImageRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Image::class);
    }

    public function getImageById($Id)
    {
        return $this->createQueryBuilder('image')
            ->andWhere('image.id=:id')
            ->setParameter('id', $Id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getImagesByAnimeId($animeID)
    {
        return $this->createQueryBuilder('image')
        ->select('image.image')
        ->andWhere('image.animeID=:animeID')
        ->setParameter('animeID',$animeID)
        ->getQuery()
        ->getResult();
    }

    public function getAll()
    {
        return $this->createQueryBuilder('image')
            ->getQuery()
            ->getResult();
    }
}
