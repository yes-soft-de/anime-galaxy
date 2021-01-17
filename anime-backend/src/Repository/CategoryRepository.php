<?php

namespace App\Repository;

use App\Entity\Category;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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
        return $this->createQueryBuilder('category')
            ->getQuery()
            ->getArrayResult();
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
        $categoriesNames = [];
        //dd($categories);
//        if ()
//        foreach ($categories as $category)
//        {
//            //dd($category);
//            $categoryName = $this->createQueryBuilder('category')
//                ->select('category.id', 'category.name')
//                ->andWhere('category.id=:id')
//                ->setParameter('id', $category)
//                ->getQuery()
//                ->getOneOrNullResult();
//
//            $categoriesNames[] = $categoryName;
//        }

        return $categoriesNames;
    }
}
