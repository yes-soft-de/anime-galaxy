<?php

namespace App\Repository;

use App\Entity\Episode;
use App\Entity\Anime;
use App\Entity\RatingEpisode;
use App\Entity\CommentEpisode;
use App\Entity\Category;
use App\Entity\UserProfile;
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
        $query = $this->createQueryBuilder('episode')
            ->select('episode.id', 'episode.image', 'episode.seasonNumber', 'episode.episodeNumber', 'episode.description',
                'episode.duration', 'episode.publishDate', 'anime.name as animeName', 'count(DISTINCT comment.id) as comments',
                'avg(rate.rateValue) as rating', 'episode.specialLink', 'episode.createdAt', 'episode.updatedAt', 'episode.createdBy', 'episode.updatedBy','userProfile.userName')

            ->leftJoin(
                Anime::class,
                'anime',
                Join::WITH,
                'anime.id = episode.animeID'
            )

            ->leftJoin(
                CommentEpisode::class,            
                'comment',                  
                Join::WITH,          
                'comment.episodeID = episode.id ' 
            )

            ->leftJoin(
                RatingEpisode::class,            
                'rate',                   
                Join::WITH,           
                'rate.episodeID = episode.id' 

            )
            ->andWhere('episode.animeID =:animeID')
            ->groupBy('episode.id')
            ->setParameter('animeID', (INT)$animeID)

            ->leftJoin(
                UserProfile::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = episode.createdBy'
            );

        return $query->addSelect('userprofile.userName as username2')

            ->leftJoin(
                UserProfile::class,
                'userprofile',
                Join::WITH,
                'userprofile.userID = episode.updatedBy'
            )

            ->getQuery()
            ->getResult();
    }

    public function getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber)
    {
        $query = $this->createQueryBuilder('episode')
        ->select('episode.id', 'episode.image', 'episode.seasonNumber', 'episode.episodeNumber', 'episode.description',
            'episode.duration', 'episode.publishDate', 'anime.name as animeName', 'count(DISTINCT comment.id) as comments',
            'avg(rate.rateValue) as rating', 'episode.specialLink', 'episode.createdAt', 'episode.updatedAt', 'episode.createdBy', 'episode.updatedBy','userProfile.userName')
        
        ->leftJoin(
            Anime::class,
            'anime',
            Join::WITH,
            'anime.id = episode.animeID'
        )
        
        ->leftJoin(
            CommentEpisode::class,            
            'comment',                  
            Join::WITH,          
            'comment.episodeID = episode.id ' 
        )
        
        ->leftJoin(
            RatingEpisode::class,            
            'rate',                   
            Join::WITH,           
            'rate.episodeID = episode.id' 
        )
        
        ->leftJoin(
            UserProfile::class,
            'userProfile',
            Join::WITH,
            'userProfile.userID = episode.createdBy'
        )

        ->andWhere('episode.animeID = :animeID')
        ->andWhere('episode.seasonNumber = :seasonNumber')
        ->groupBy('episode.id')
        ->setParameter('animeID', (INT)$animeID)
        ->setParameter('seasonNumber', (INT)$seasonNumber);
        
        return $query->addSelect('userprofile.userName as username2')

            ->leftJoin(
                UserProfile::class,
                'userprofile',
                Join::WITH,
                'userprofile.userID = episode.updatedBy'
            )
        
            ->getQuery()
            ->getResult();

    }

    public function getEpisodeById($id)
    {
       return $this->createQueryBuilder('episode')
        ->select('episode.id','episode.seasonNumber', 'episode.episodeNumber', 'episode.description', 'episode.image', 'episode.posterImage',
            'episode.duration', 'episode.publishDate', 'episode.createdAt', 'anime.name as animeName', 'episode.specialLink','anime.publishDate as animePublishDate',
            'episode.categories as cats', 'avg(rate.rateValue) as rating', 'anime.id as animeID')
    
        ->leftJoin(
            Anime::class,
            'anime',
            Join::WITH,
            'anime.id = episode.animeID'
        )
//        ->leftJoin(
//            Category::class,
//            'category',
//            Join::WITH,
//            'category.id = episode.categoyID'
//        )
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

    public function getAllComingSoon($date)
    {        
        return $this->createQueryBuilder('episode')
            ->select('episode.id', 'episode.description', 'episode.episodeNumber', 'episode.image', 'episode.duration',
                'episode.publishDate', 'episode.createdAt', 'episode.seasonNumber', 'anime.name as animeName',
                'episode.specialLink','episode.categories as cats', 'episode.posterImage', 'episode.posterSpecialLink')
            ->leftJoin(
                Anime::class,
                'anime',
                Join::WITH,
                'anime.id = episode.animeID'
            )
//            ->leftJoin(
//                Category::class,
//                'category',
//                Join::WITH,
//                'category.id = episode.categoyID'
//            )
            ->andWhere( 'episode.publishDate > :date')
            ->setParameter('date',$date)
            ->groupBy('episode.id')
            ->getQuery()
            ->getResult();
            
    }
}
