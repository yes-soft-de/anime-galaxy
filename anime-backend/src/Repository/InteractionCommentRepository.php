<?php

namespace App\Repository;

use App\Entity\InteractionComment;
use App\Entity\Comment;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use phpDocumentor\Reflection\DocBlock\Tags\Return_;

/**
 * @method InteractionComment|null find($id, $lockMode = null, $lockVersion = null)
 * @method InteractionComment|null findOneBy(array $criteria, array $orderBy = null)
 * @method InteractionComment[]    findAll()
 * @method InteractionComment[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class InteractionCommentRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, InteractionComment::class);
    }

    public function getAll($id)
    {
        return $this->createQueryBuilder('interaction')
        ->andWhere('interaction.commentID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getInteractionWithUser($commentID, $userID)
    {
        return $this->createQueryBuilder('interaction')
        ->andWhere('interaction.commentID = :commentID')
        ->andWhere('interaction.userID  = :userID')
        ->setParameter('commentID', $commentID)
        ->setParameter('userID', $userID)
        ->getQuery()
        ->getResult();
    }

    public function getAllLikes($id)
    {
        // Like = 1
        return $this->createQueryBuilder('interaction')
            ->select('count(interaction.type)')

            ->andWhere('interaction.commentID = :id')
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

        ->andWhere('interaction.commentID = :id')
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

            ->andWhere('interaction.commentID = :id')
            ->andWhere('interaction.type = 3')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllInteractions($id)
    {
        //count all interaction
        return $this->createQueryBuilder('interaction')
        ->andWhere('interaction.commentID = :id')
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
       ->andWhere('interaction.commentID = :id')
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
       ->andWhere('interaction.commentID = :id')
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
       ->andWhere('interaction.commentID = :id')
       ->andWhere('interaction.type = 2')
       ->setParameter('id', $id)
       ->getQuery()
       ->getOneOrNullResult();
    }

}
