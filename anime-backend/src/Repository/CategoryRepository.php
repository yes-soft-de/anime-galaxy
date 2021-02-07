<?php

namespace App\Repository;

use App\Entity\Category;
use App\Entity\UserProfile;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Category|null find($id, $lockMode = null, $lockVersion = null)
 * @method Category|null findOneBy(array $criteria, array $orderBy = null)
 * @method Category[]    findAll()
 * @method Category[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CategoryRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Category::class);
    }

    public function getAll()
    {
        $query = $this->createQueryBuilder('category')
            ->select('category.id', 'category.name', 'category.description', 'category.image', 'category.coverImage',
             'category.createdAt', 'category.updatedAt', 'category.createdBy', 'category.updatedBy', 'userProfile.userName')

            ->leftJoin(
                UserProfile::class,
                'userProfile',
                Join::WITH,
                'userProfile.userID = category.createdBy'
            );

        return $query->addSelect('userprofile.userName as username2')

            ->leftJoin(
                UserProfile::class,
                'userprofile',
                Join::WITH,
                'userprofile.userID = category.updatedBy'
            )

            ->getQuery()
            ->getResult();
    }

    public function getCategoryById($id): ?Category
    {
        return $this->createQueryBuilder('category')
            ->andWhere('category.id=:id')
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCategoriesArray($categories)
    {
        return $this->createQueryBuilder('category')
                    ->select('category.id', 'category.name')
                    ->andWhere('category.id IN (:ids)')
                    ->setParameter('ids', $categories)
                    ->getQuery()
                    ->getArrayResult();
    }
}
