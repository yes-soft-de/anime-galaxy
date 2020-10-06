<?php

namespace App\Repository;

use App\Entity\Interaction;
use App\Entity\Anime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use phpDocumentor\Reflection\DocBlock\Tags\Return_;

/**
 * @method Interaction|null find($id, $lockMode = null, $lockVersion = null)
 * @method Interaction|null findOneBy(array $criteria, array $orderBy = null)
 * @method Interaction[]    findAll()
 * @method Interaction[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class InteractionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Interaction::class);
    }

    public function getAll($id)
    {
        return $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getInteractionWithUser($animeID, $userID)
    {
        return $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :animeID')
        ->andWhere('interaction.userID  = :userID')
        ->setParameter('animeID', $animeID)
        ->setParameter('userID', $userID)
        ->getQuery()
        ->getResult();
    }

    public function getAllLikes($id)
    {
        // Like = 1
        return $this->createQueryBuilder('interaction')
            ->select('count(interaction.type)')

            ->andWhere('interaction.animeID = :id')
            ->andWhere('interaction.type = 1')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllDislike($id)
    {
        // disLike = 2
        return $this->createQueryBuilder('interaction')
        ->select('count(interaction.type)')

        ->andWhere('interaction.animeID = :id')
        ->andWhere('interaction.type = 2')

        ->setParameter('id', $id)

        ->getQuery()
        ->getOneOrNullResult();
    }

    public function getAllLove($id)
    {
        // love = 3
        return $this->createQueryBuilder('interaction')
            ->select('count(interaction.type)')

            ->andWhere('interaction.animeID = :id')
            ->andWhere('interaction.type = 3')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllInteractions($id)
    {
        //count all interaction
        return $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->select('count(interaction.type) as CountAllInteraction')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getLoveAll($id)
    {
       // love = 3
       return $this->createQueryBuilder('interaction')
       ->select('count(interaction.type)')
       ->andWhere('interaction.animeID = :id')
       ->andWhere('interaction.type = 3')
       ->setParameter('id', $id)
       ->getQuery()
       ->getOneOrNullResult();
    }

    public function getLikeAll($id)
    {
       // like = 1
       return $this->createQueryBuilder('interaction')
       ->select('count(interaction.type)')
       ->andWhere('interaction.animeID = :id')
       ->andWhere('interaction.type = 1')
       ->setParameter('id', $id)
       ->getQuery()
       ->getOneOrNullResult();
    }

    public function dislikeAll($id)
    {
       // dislike = 2
       return $this->createQueryBuilder('interaction')
       ->select('count(interaction.type)')
       ->andWhere('interaction.animeID = :id')
       ->andWhere('interaction.type = 2')
       ->setParameter('id', $id)
       ->getQuery()
       ->getOneOrNullResult();
    }

    public function countInteractions($id)
    {
        //ToDo: this needs remove after finish
      return [
          $this->getAllLikes($id),
          $this->getAllDisLikes($id),
          $this->getAllLove($id),
          $this->getAllInteractions($id)
      ];
    }

}
