<?php

namespace App\Repository;

use App\Entity\CommentEpisode;
use App\Entity\Episode;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

    public function getAll($episodeID)
    {
        return $this->createQueryBuilder('CommentEpisode')
        ->andWhere('CommentEpisode.episodeID = :episodeID')
        ->setParameter('episodeID', $episodeID)
        ->getQuery()
        ->getResult();
    }

    public function getCommentsByEpisodeId($episodeID)
    {
        return $this->createQueryBuilder('CommentEpisode')
            ->select('CommentEpisode.comment, CommentEpisode.spoilerAlert, CommentEpisode.creationDate')
            ->from('App:Episode','episode')
            ->andWhere('episode.id=CommentEpisode.episodeID')
            ->andWhere('episode.id=:episodeID')
            ->setParameter('episodeID', $episodeID)
            ->getQuery()
            ->getResult();
    }
}
