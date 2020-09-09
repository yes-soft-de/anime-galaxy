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

    // /**
    //  * @return InterAction[] Returns an array of InterAction objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('i')
            ->andWhere('i.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('i.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?InterAction
    {
        return $this->createQueryBuilder('i')
            ->andWhere('i.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
