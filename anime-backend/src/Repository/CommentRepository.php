<?php

namespace App\Repository;

use App\Entity\Comment;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Service\FollowService;
use App\Entity\Anime;
use Doctrine\ORM\Query\Expr\Join;
/**
 * @method Comment|null find($id, $lockMode = null, $lockVersion = null)
 * @method Comment|null findOneBy(array $criteria, array $orderBy = null)
 * @method Comment[]    findAll()
 * @method Comment[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommentRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Comment::class);
    }

    public function getCommentById($id)
    {
        return $this->createQueryBuilder('Comment')
    
            ->select('Comment.id','Comment.comment as comment','Comment.userID','Comment.animeID','Comment.spoilerAlert','Comment.creationDate')
            ->andWhere('Comment.id=:id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getResult();
    }

    public function getAll($id)
    {
        return $this->createQueryBuilder('Comment')
        ->select('Comment.id','Comment.comment as comment','Comment.userID','Comment.animeID','Comment.spoilerAlert','Comment.creationDate')
        ->andWhere('Comment.animeID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getCommentsByAnimeId($animeID)
    {
        return $this->createQueryBuilder('comment')
            ->select('comment.id,comment.comment, comment.spoilerAlert, comment.creationDate')
            ->from('App:Anime','anime')
            ->andWhere('anime.id=comment.animeID')
            ->andWhere('anime.id=:animeID')
            ->setParameter('animeID', $animeID)
            ->getQuery()
            ->getResult();
    }

    public function getFollowersComments($friendID, $date)
    {
        return $this->createQueryBuilder('comment')
            ->select('comment.userID','comment.id as commentID','comment.comment ','comment.creationDate as commentDate')
            ->addSelect('Anime.id as animeID','Anime.name as AnimeName')

            ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'comment.animeID = Anime.id'
            )
            ->andWhere('comment.creationDate in (:date)')
            ->andWhere('comment.userID = :friendID')         
            ->setParameter('friendID',$friendID)
            ->setParameter('date',$date)
            ->setMaxResults(3) 
            ->addOrderBy('comment.creationDate','DESC')
            ->getQuery()
            ->getResult();
            
    }
}
