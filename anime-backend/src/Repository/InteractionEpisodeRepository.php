<?php

namespace App\Repository;

use App\Entity\InteractionEpisode;
use App\Entity\Episode;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use phpDocumentor\Reflection\DocBlock\Tags\Return_;

/**
 * @method InteractionEpisode|null find($id, $lockMode = null, $lockVersion = null)
 * @method InteractionEpisode|null findOneBy(array $criteria, array $orderBy = null)
 * @method InteractionEpisode[]    findAll()
 * @method InteractionEpisode[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class InteractionEpisodeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, InteractionEpisode::class);
    }

    public function getAll($episodeID)
    {
        return $this->createQueryBuilder('interactionEpisode')
        ->andWhere('interactionEpisode.episodeID = :episodeID')
        ->setParameter('episodeID', $episodeID)
        ->getQuery()
        ->getResult();
    }

    public function getInteractionWithUser($episodeID, $userID)
    {
        return $this->createQueryBuilder('interactionEpisode')
        ->andWhere('interactionEpisode.episodeID = :episodeID')
        ->andWhere('interactionEpisode.userID  = :userID')
        ->setParameter('episodeID', $episodeID)
        ->setParameter('userID', $userID)
        ->getQuery()
        ->getResult();
    }

    public function getAllLikes($id)
    {
        // Like = 1
        return $this->createQueryBuilder('interactionEpisode')
            ->select('count(interactionEpisode.type)')

            ->andWhere('interactionEpisode.episodeID = :id')
            ->andWhere('interactionEpisode.type = 1')

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllDislike($id)
    {
        // disLike = 2
        return $this->createQueryBuilder('interactionEpisode')
        ->select('count(interactionEpisode.type)')

        ->andWhere('interactionEpisode.episodeID = :id')
        ->andWhere('interactionEpisode.type = 2')

        ->setParameter('id', $id)

        ->getQuery()
        ->getOneOrNullResult();
    }

    public function getAllLove($id)
    {
        // love = 3
        return $this->createQueryBuilder('interactionEpisode')
            ->select('count(interactionEpisode.type)')

            ->andWhere('interactionEpisode.episodeID = :id')
            ->andWhere('interactionEpisode.type = 3')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllInteractions($id)
    {
        //count all interaction
        return $this->createQueryBuilder('interactionEpisode')
        ->andWhere('interactionEpisode.episodeID = :id')
        ->select('count(interactionEpisode.type) as CountAllInteraction')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getLoveAll($ID)
    {
       // love = 3
       return $this->createQueryBuilder('interactionEpisode')
       ->select('count(interactionEpisode.id)')
       ->andWhere('interactionEpisode.episodeID = :id')
       ->andWhere('interactionEpisode.type = 3')
       ->setParameter('id', $ID)
       ->getQuery()
       ->getOneOrNullResult();
    }

    public function getLikeAll($ID)
    {
       // like = 1
       return $this->createQueryBuilder('interactionEpisode')
       ->select('count(interactionEpisode.id)')
       ->andWhere('interactionEpisode.episodeID = :id')
       ->andWhere('interactionEpisode.type = 1')
       ->setParameter('id', $ID)
       ->getQuery()
       ->getOneOrNullResult();
    }

    public function dislikeAll($id)
    {
       // dislike = 2
       return $this->createQueryBuilder('interactionEpisode')
       ->select('count(interactionEpisode.type)')
       ->andWhere('interactionEpisode.episodeID = :id')
       ->andWhere('interactionEpisode.type = 2')
       ->setParameter('id', $id)
       ->getQuery()
       ->getOneOrNullResult();
    }

}
