<?php

namespace App\Repository;

use App\Entity\User;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method UserProfile|null find($id, $lockMode = null, $lockVersion = null)
 * @method UserProfile|null findOneBy(array $criteria, array $orderBy = null)
 * @method UserProfile[]    findAll()
 * @method UserProfile[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserProfileRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, UserProfile::class);
    }

    public function getProfileByUSerID($userID)
    {
        return $this->createQueryBuilder('profile')
            ->select('user.createdAt as createdAt','profile.userID', 'profile.userName', 'profile.location', 'profile.image',
                'profile.image', 'profile.story', 'profile.cover', 'profile.coverSpecialLink')
            ->leftJoin(
                User::class,
                'user',
                Join::WITH,
                'user.userID = profile.userID'
            )
            ->andWhere('profile.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getUserProfile($userID)
    {
        return $this->createQueryBuilder('profile')

            ->andWhere('profile.userID=:userID')
            ->setParameter('userID', $userID)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllProfiles()
    {
        return $this->createQueryBuilder('profile')
            ->getQuery()
            ->getResult();
    }

    public function deleteAllProfiles()
    {
        return $this->createQueryBuilder('profile')
            ->delete()
            ->getQuery()
            ->execute();
    }
}
