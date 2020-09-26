<?php

namespace App\Repository;

use App\Entity\Interaction;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

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
        return  $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getInteractionWithUser($animeID, $userID)
    {
        return  $res= $this->createQueryBuilder('interaction')
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
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->andWhere('interaction.type = 1')
        ->select('count(interaction.type) as Like')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllDisLikes($id)
    {
        // disLike = 2
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->andWhere('interaction.type = 2')
        ->select('count(interaction.type) as DisLike')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllLove($id)
    {
        // love = 3
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->andWhere('interaction.type = 3')
        ->select('count(interaction.type) as Love')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllInteractions($id)
    {
        //count all interaction
         $res= $this->createQueryBuilder('interaction')
        ->andWhere('interaction.animeID = :id')
        ->select('count(interaction.type) as CountAllInteraction')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function countInteractions($id)
    {

      $arr=[
          $this->getAllLikes($id),
          $this->getAllDisLikes($id),
          $this->getAllLove($id),
          $this->getAllInteractions($id)
      ]; 
     
      return $arr;
    }

}
