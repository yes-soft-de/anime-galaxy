<?php

namespace App\Repository;

use App\Entity\Anime;
use App\Entity\CommentEpisode;
use App\Entity\Episode;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CommentEpisode|null find($id, $lockMode = null, $lockVersion = null)
 * @method CommentEpisode|null findOneBy(array $criteria, array $orderBy = null)
 * @method CommentEpisode[]    findAll()
 * @method CommentEpisode[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommentEpisodeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CommentEpisode::class);
    }

    public function getCommentById($id)
    {
        return $this->createQueryBuilder('CommentEpisode')
    
            ->select('CommentEpisode.id','CommentEpisode.comment as comment','CommentEpisode.userID','CommentEpisode.episodeID','CommentEpisode.spoilerAlert','CommentEpisode.creationDate')
            ->andWhere('CommentEpisode.id=:id')
            ->setParameter('id',$id)
            ->getQuery()
            ->getResult();
    }

    public function getAll($episodeID)
    {
        return $this->createQueryBuilder('CommentEpisode')
        ->select('CommentEpisode.id','CommentEpisode.comment as comment','CommentEpisode.userID','CommentEpisode.episodeID','CommentEpisode.spoilerAlert','CommentEpisode.creationDate')
        ->andWhere('CommentEpisode.episodeID = :episodeID')
        ->setParameter('episodeID', $episodeID)
        ->getQuery()
        ->getResult();
    }

    public function getCommentsByEpisodeId($episodeID)
    {
        return $this->createQueryBuilder('CommentEpisode')
            ->select('CommentEpisode.id', 'CommentEpisode.userID', 'CommentEpisode.comment', 'CommentEpisode.spoilerAlert', 'CommentEpisode.creationDate')
            ->addSelect('userProfile.userID', 'userProfile.userName','userProfile.image')
            ->from('App:Episode','episode')

            ->leftJoin(
                UserProfile::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = CommentEpisode.userID'
            )

            ->andWhere('episode.id=CommentEpisode.episodeID')
            ->andWhere('episode.id=:episodeID')
            ->setParameter('episodeID', $episodeID)
            ->getQuery()
            ->getResult();
    }

    public function getCommentsByUserId($userID)
    {
        return $this->createQueryBuilder('comment')
            ->select('comment.id, comment.comment, anime.name as animeName, comment.spoilerAlert, comment.creationDate, episode.episodeNumber')
            ->addSelect('userProfile.userName','userProfile.image')

            ->leftJoin(
                UserProfile::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = comment.userID'
            )

            ->leftJoin(
                Episode::class,
                'episode',
                Join::WITH,
                'episode.id = comment.episodeID'
            )

            ->leftJoin(
                Anime::class,
                'anime',
                Join::WITH,
                'anime.id = episode.animeID'
            )

            ->andWhere('comment.userID = :userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getResult();
    }

    public function getEpisodeCommentsNumbers($userID)
    {
        return $this->createQueryBuilder('comment')
            ->select('count(comment.id) as commentsNumber')
            ->andWhere('comment.userID=:userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getResult();
    }
}
