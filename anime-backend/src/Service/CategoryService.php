<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Category;
use App\Manager\CategoryManager;
use App\Response\CreateCategoryResponse;
use App\Response\GetCategoryByIdResponse;
use App\Response\GetCategoryResponse;
use App\Response\UpdateCategoryResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class CategoryService

{
    private $categoryManager;
    private $autoMapping;
    private $params;

    public function __construct(CategoryManager $categoryManager, AutoMapping $autoMapping, ParameterBagInterface $params)
    {
        $this->categoryManager =$categoryManager;
        $this->autoMapping = $autoMapping;
        $this->params = $params->get('upload_base_url') . '/';
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
            $row['imageURL'] = $row['image'];

            $row['coverImageURL'] = $row['coverImage'];

            $row['baseURL'] = $this->params;

            $row['image'] = $this->params.$row['image'];

            $row['coverImage'] = $this->params.$row['coverImage'];

            $row['createdBy'] = $row['userName'];
            $row['updatedBy'] = $row['username2'];

            $response[] = $this->autoMapping->map('array', GetCategoryResponse::class, $row);
        }

        return $response;
    }

    public function getCategoryById($request)
    {
        $result = $this->categoryManager->getCategoryById($request);

        $response =  $this->autoMapping->map(Category::class, GetCategoryByIdResponse::class, $result);

        $response->setImageURL($response->getImage());
        $response->setCoverImageURL($response->getCoverImage());
        $response->setBaseURL($this->params);
        $response->setImage($this->params.$response->getImageURL());
        $response->setCoverImage($this->params.$response->getCoverImage());

        return $response;
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

    public function getCategoriesArray($categories)
    {
        return $this->categoryManager->getCategoriesArray($categories);
    }
}