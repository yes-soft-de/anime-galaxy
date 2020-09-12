<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Categories;
use App\Entity\Category;
use App\Entity\Project;
use App\Manager\CategoryManager;
use App\Response\CreateCategoryResponse;
use App\Response\GetCategoryByIdResponse;
use App\Response\GetCategoryResponse;
use App\Response\UpdateCategoryResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Exception\NoConfigurationException;
use Doctrine\ORM\NonUniqueResultException;

class CategoryService

{
    private $categoryManager;
    private $autoMapping;


    public function __construct(CategoryManager $categoryManager, AutoMapping $autoMapping)
    {
        $this->categoryManager =$categoryManager;
        $this->autoMapping = $autoMapping;
    }

    public function create($request)
    {  
        $categoryResult = $this->categoryManager->create($request);
        $response = $this->autoMapping->map(Category::class, CreateCategoryResponse::class,
            $categoryResult);
        return $response;
    }
    
    
    public function getAll()
    {
        $result = $this->categoryManager->getAll();
        $response=[];
        foreach ($result as $row)
            $response[] = $this->autoMapping->map(Category::class, GetCategoryResponse::class, $row);
        return $response;
    }


    public function getCategoryById($request)
    {
        $result = $this->categoryManager->getCategoryById($request);
        $response = $this->autoMapping->map(Category::class, GetCategoryByIdResponse::class, $result);
        return $response;
    }


    public function delete($request)
    {
        $result = $this->categoryManager->delete($request);
        if(!($result instanceof Category))
            return $result;
        $response = $this->autoMapping->map(Category::class, GetCategoryByIdResponse::class, $result);
        return $response;
    }

    public function update($request)
    {
        $categoryResult = $this->categoryManager->update($request);
        $response = $this->autoMapping->map(Category::class, UpdateCategoryResponse::class, $categoryResult);
        $response->setName($request->getName());
        return $response;
    }
}