<?php

namespace App\Repository;

use App\Entity\Episode;
use App\Entity\Anime;
use App\Entity\RatingEpisode;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;


/**
 * @method Episode|null find($id, $lockMode = null, $lockVersion = null)
 * @method Episode|null findOneBy(array $criteria, array $orderBy = null)
 * @method Episode[]    findAll()
 * @method Episode[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EpisodeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Episode::class);
    }

    public function getEpisodesByAnimeId($animeID)
    {
        return $this->createQueryBuilder('e')
            ->andWhere('e.animeID = :animeID')
            ->setParameter('animeID', $animeID)
            ->orderBy('e.id', 'ASC')
            ->getQuery()
            ->getResult()
        ;
    }

    public function getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber)
    {
        return $this->createQueryBuilder('e')
            ->andWhere('e.animeID = :animeID')
            ->andWhere('e.seasonNumber = :seasonNumber')
            ->setParameter('animeID', $animeID)
            ->setParameter('seasonNumber', $seasonNumber)
            ->orderBy('e.id', 'ASC')
            ->getQuery()
            ->getResult()
            ;
    }

    public function getEpisodeById($id)
    {
       return $this->createQueryBuilder('episode')
        ->select('episode.id','episode.seasonNumber','episode.episodeNumber','episode.description','episode.image','episode.duration','episode.publishDate','episode.createdAt','anime.name as animeName',
        'avg(rate.rateValue) as rating')
    
        ->leftJoin(
            Anime::class,
            'anime',
            Join::WITH,
            'anime.id = episode.animeID'
        )
        ->leftJoin(
            RatingEpisode::class,            
            'rate',                   
            Join::WITH,           
            'rate.episodeID = episode.id' 
        )

        ->andWhere('episode.id=:id')
        ->setParameter('id',(INT) $id)

        ->groupBy('episode.id')
        ->orderBy('episode.id')

        ->getQuery()
        ->getResult();

    }



    public function getAllCommingSoon($date)
    {        
        return $this->createQueryBuilder('episode')
            ->select('episode.id', 'episode.description','episode.episodeNumber','episode.image','episode.duration','episode.publishDate','episode.createdAt','episode.seasonNumber','anime.name as animeName')
            ->leftJoin(
                Anime::class,
                'anime',
                Join::WITH,
                'anime.id = episode.animeID'
            )
            ->andWhere( 'episode.createdAt > :date')
            ->setParameter('date',$date)
            ->groupBy('episode.id')
            ->getQuery()
            ->getResult();
            
    }
}
