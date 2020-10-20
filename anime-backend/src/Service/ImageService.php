<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Image;
use App\Manager\ImageManager;
use App\Response\CreateImageResponse;
use App\Response\GetImageByIdResponse;
use App\Response\GetImageResponse;
use App\Response\UpdateImageResponse;

class ImageService

{
    private $imageManager;
    private $autoMapping;

    public function __construct(ImageManager $imageManager, AutoMapping $autoMapping)
    {
        $this->imageManager =$imageManager;
        $this->autoMapping = $autoMapping;
    }

    public function create($request)
    {  
        $imageResult = $this->imageManager->create($request);

        return $this->autoMapping->map(Image::class, CreateImageResponse::class,
            $imageResult);
    }
    
    public function getAll()
    {
        $response=[];
        $result = $this->imageManager->getAll();

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Image::class, GetImageResponse::class, $row);
        }

        return $response;
    }

    public function getImagesByAnimeId($request)
    {
        $response = [];
        $result = $this->imageManager->getImagesByAnimeID($request);
        
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetImageResponse::class, $row);
        }

        return $response;
    }

    public function delete($request)
    {
        $result = $this->imageManager->delete($request);

        return $this->autoMapping->map(Image::class, GetImageByIdResponse::class, $result);
    }

    public function update($request)
    {
        $imageResult = $this->imageManager->update($request);

        $response = $this->autoMapping->map(Image::class, UpdateImageResponse::class, $imageResult);
        return $response;
    }


}