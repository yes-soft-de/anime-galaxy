<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Category;
use App\Manager\CategoryManager;
use App\Response\CreateCategoryResponse;
use App\Response\GetCategoryByIdResponse;
use App\Response\GetCategoryResponse;
use App\Response\UpdateCategoryResponse;

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

        return $this->autoMapping->map(Category::class, CreateCategoryResponse::class,
            $categoryResult);
    }
    
    public function getAll()
    {
        $result = $this->categoryManager->getAll();
        $response=[];

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Category::class, GetCategoryResponse::class, $row);
        }

        return $response;
    }

    public function getCategoryById($request)
    {
        $result = $this->categoryManager->getCategoryById($request);

        return  $this->autoMapping->map(Category::class, GetCategoryByIdResponse::class, $result);
    }

    public function delete($request)
    {
        $result = $this->categoryManager->delete($request);

        if(!($result instanceof Category))
        {
            return $result;
        }

        return $this->autoMapping->map(Category::class, GetCategoryByIdResponse::class, $result);
    }

    public function update($request)
    {
        $categoryResult = $this->categoryManager->update($request);

        $response = $this->autoMapping->map(Category::class, UpdateCategoryResponse::class, $categoryResult);
        $response->setName($request->getName());

        return $response;
    }
}