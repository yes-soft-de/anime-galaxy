<?php

namespace App\Repository;

use App\Entity\InterAction;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method InterAction|null find($id, $lockMode = null, $lockVersion = null)
 * @method InterAction|null findOneBy(array $criteria, array $orderBy = null)
 * @method InterAction[]    findAll()
 * @method InterAction[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class InterActionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, InterAction::class);
    }

    public function getAll($id)
    {
        return  $res= $this->createQueryBuilder('InterAction')
        ->andWhere('InterAction.animeID = :id')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
    }

    public function getInterActionwithUser($animeID, $userID)
    {
        return  $res= $this->createQueryBuilder('InterAction')
        ->andWhere('InterAction.animeID = :animeID')
        ->andWhere('InterAction.userID  = :userID')
        ->setParameter('animeID', $animeID)
        ->setParameter('userID', $userID)
        ->getQuery()
        ->getResult();
    }

    public function getAllLikes($id)
    {
        // Like = 1
         $res= $this->createQueryBuilder('InterAction')
        ->andWhere('InterAction.animeID = :id')
        ->andWhere('InterAction.type = 1')
        ->select('count(InterAction.type) as Like')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllDisLikes($id)
    {
        // disLike = 2
         $res= $this->createQueryBuilder('InterAction')
        ->andWhere('InterAction.animeID = :id')
        ->andWhere('InterAction.type = 2')
        ->select('count(InterAction.type) as DisLike')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllLove($id)
    {
        // love = 3
         $res= $this->createQueryBuilder('InterAction')
        ->andWhere('InterAction.animeID = :id')
        ->andWhere('InterAction.type = 3')
        ->select('count(InterAction.type) as Love')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function getAllInerAction($id)
    {
        //count all interaction
         $res= $this->createQueryBuilder('InterAction')
        ->andWhere('InterAction.animeID = :id')
        ->select('count(InterAction.type) as CountAllInteraction')
        ->setParameter('id', $id)
        ->getQuery()
        ->getResult();
       
        return $res;
    }

    public function countInerActions($id)
    {

      $arr=[
          $this->getAllLikes($id),
          $this->getAllDisLikes($id),
          $this->getAllLove($id),
          $this->getAllInerAction($id)          
      ]; 
     
      return $arr;
    }

}
