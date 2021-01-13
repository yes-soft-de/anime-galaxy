<?php
namespace App\Manager;

use App\AutoMapping;

use App\Entity\Category;
use App\Repository\CategoryRepository;
use App\Request\CreateCategoryRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use App\Request\GetByIdRequest;
use App\Request\DeleteRequest;
use App\Request\UpdateCategoryRequest;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;


class CategoryManager
{
    private $entityManager;
    private $categoryRepository;
    private $autoMapping;   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    CategoryRepository $categoryRepository, AutoMapping $autoMapping )
    {
        $this->entityManager         = $entityManagerInterface;
        $this->categoryRepository    = $categoryRepository;
        $this->autoMapping           = $autoMapping;
    }

    public function create(CreateCategoryRequest $request)
    {
        $categoryEntity = $this->autoMapping->map(CreateCategoryRequest::class, Category::class, $request);
        $this->entityManager->persist($categoryEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $categoryEntity;
    }


    public function getAll()
    {
        $data = $this->categoryRepository->getAll();

        return $data;
    }

    public function getCategoryById(GetByIdRequest $request)
    {
        return $result = $this->categoryRepository->getCategoryById($request->getId());
    }
    
    
    public function delete(DeleteRequest $request)
    {
        $category = $this->categoryRepository->getCategoryById($request->getId());
        if (!$category )
        {
            return $category;
        }
         else
             {

            $this->entityManager->remove($category);
            $this->entityManager->flush();
         }
         return $category;
    }
    public function update(UpdateCategoryRequest $request)
    {
        $categoryEntity = $this->categoryRepository->getCategoryById($request->getId());
        
        if (!$categoryEntity) {
           
        } else {
            $categoryEntity = $this->autoMapping->mapToObject(UpdateCategoryRequest::class,
            Category::class, $request, $categoryEntity);
            $this->entityManager->flush();
            return $categoryEntity;
        }
    }

    public function getCategoriesArray($categories)
    {
        return $this->categoryRepository->getCategoriesArray($categories);
    }

}
