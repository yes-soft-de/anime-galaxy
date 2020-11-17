<?php

namespace App\Repository;

use App\Entity\Grade;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Grade|null find($id, $lockMode = null, $lockVersion = null)
 * @method Grade|null findOneBy(array $criteria, array $orderBy = null)
 * @method Grade[]    findAll()
 * @method Grade[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class GradeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Grade::class);
    }

    public function getGradeById($Id): ?Grade
    {
        return $this->createQueryBuilder('grade')
            ->andWhere('grade.id = :id')
            ->setParameter('id', $Id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getGradeByUserId($userID)
    {
        return $this->createQueryBuilder('grade')
            ->andWhere('grade.userID = :userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getTopUsers()
    {
        return $this->createQueryBuilder('grade')
            ->select('grade.points, userprofile.userName as username, userprofile.image as image')
            ->leftJoin(
                UserProfile::class,
                "userprofile",
                Join::WITH,
                'grade.userID = userprofile.userID'
            )
            ->orderBy('grade.points','DESC')
            ->setMaxResults(50)
            ->getQuery()
            ->getResult();
    }
}
