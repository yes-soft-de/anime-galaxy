<?php

namespace App\Repository;

use App\Entity\Image;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\Anime;
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
        $res = $this->createQueryBuilder('image')
            ->andWhere('image.id=:id')
            ->setParameter('id', $Id)
            ->getQuery()
            ->getOneOrNullResult();

        return $res;
    }

    public function getImagesByAnimeId($animeID)
    {
        $result=$this->createQueryBuilder('image')
        ->select('image.image')
        ->from('App:Anime','anime')
        ->andWhere('anime.id=image.animeID')
        ->andWhere('anime.id=:animeID')
        ->setParameter('animeID',$animeID)
        ->getQuery()
        ->getResult();

        return $result;
    }

    public function getAll()
    {
        $res = $this->createQueryBuilder('image')
            ->getQuery()
            ->getResult();

        return $res;
    }
}
