<?php

namespace App\Repository;

use App\Entity\User;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\DBAL\ParameterType;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * @method User|null find($id, $lockMode = null, $lockVersion = null)
 * @method User|null findOneBy(array $criteria, array $orderBy = null)
 * @method User[]    findAll()
 * @method User[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserRepository extends ServiceEntityRepository implements PasswordUpgraderInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, User::class);
    }

    /**
     * Used to upgrade (rehash) the user's password automatically over time.
     */
    public function upgradePassword(UserInterface $user, string $newEncodedPassword): void
    {
        if (!$user instanceof User) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
        }

        $user->setPassword($newEncodedPassword);
        $this->_em->persist($user);
        $this->_em->flush();
    }

    public function getUserByUserID($userID)
    {
        return $this->createQueryBuilder('user')
            ->andWhere('user.userID = :userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult()
            ;
    }

    public function getAllAdministrators()
    {
        $adminRole = "ROLE_ADMIN";

        return $this->createQueryBuilder('user')
            ->select('user.id', 'user.createdAt', 'user.roles', 'user.userID', 'profile.userName', 'profile.location',
                'profile.image', 'profile.story', 'profile.cover', 'profile.coverSpecialLink')

            ->leftJoin(
                UserProfile::class,
                'profile',
                Join::WITH,
                'profile.userID = user.userID'
            )
            ->andWhere('user.roles LIKE :roles')
            ->setParameter('roles', '%"'.$adminRole.'"%')

            ->getQuery()
            ->getResult();
    }

    public function getUserByEmail($email)
    {
        return $this->createQueryBuilder('user')
            ->andWhere('user.email = :email')
            ->setParameter('email', $email)
            ->getQuery()
            ->getOneOrNullResult()
            ;
    }

    public function getAllUsers()
    {
        return $this->createQueryBuilder('user')
            ->getQuery()
            ->getResult();
    }
}
