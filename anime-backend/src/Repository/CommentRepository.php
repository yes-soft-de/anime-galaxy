<?php

namespace App\Repository;

use App\Entity\Comment;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Service\FollowService;
use App\Entity\Anime;
use App\Entity\UserProfile;
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
        ->addSelect('userProfile.userName','userProfile.image')
        ->leftJoin(
            UserProfile::class,
            'userProfile',
             Join::WITH,
            'Comment.userID = userProfile.userID '
        )
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
    public function commentsNumber($userID)
    {
        return $this->createQueryBuilder('comment')
            ->select('count(comment.id) as commentsNumber')
            ->andWhere('comment.userID=:userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getResult();
    }

    public function getFollowersComments($friendID, $date)
    {
        return $this->createQueryBuilder('comment')
            ->select('comment.userID','comment.id as commentID','comment.comment ','comment.creationDate as date')
            ->addSelect('Anime.id as animeID','Anime.name as AnimeName','UserProfile.userName')

            ->leftJoin(
                Anime::class,
                'Anime',
                 Join::WITH,
                'comment.animeID = Anime.id'
            )
            ->leftJoin(
                UserProfile::class,
                'UserProfile',
                 Join::WITH,
                'comment.userID = UserProfile.userID '
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
