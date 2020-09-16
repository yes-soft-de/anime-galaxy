<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Image;
use App\Entity\Images;
use App\Manager\ImageManager;
use App\Response\CreateImageResponse;
use App\Response\GetImageByIdResponse;
use App\Response\GetImageResponse;
use App\Response\UpdateImageResponse;
use Symfony\Component\HttpFoundation\Request;
use App\Response\DeleteResponse;
use Symfony\Component\Routing\Exception\NoConfigurationException;
use Doctrine\ORM\NonUniqueResultException;

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
        $response = $this->autoMapping->map(Image::class, CreateImageResponse::class,
            $imageResult);
        return $response;
    }
    
    
    public function getAll()
    {
        $result = $this->imageManager->getAll();
        $response=[];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Image::class, GetImageResponse::class, $row);
        }
        return $response;
    }


    public function getImagesByAnimeId($request)
    {
        $result = $this->imageManager->getImagesByAnimeID($request);
        $response=[];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Image::class, GetImageResponse::class, $row);
        }
        return $response;
    }


    public function delete($request)
    {
        $result = $this->imageManager->delete($request);
        $response = $this->autoMapping->map(Image::class, GetImageByIdResponse::class, $result);
        return $response;
    }

    public function update($request)
    {
        $imageResult = $this->imageManager->update($request);
        $response = $this->autoMapping->map(Image::class, UpdateImageResponse::class, $imageResult);
        $response->setImage($request->getImage());
        $response->setAnimeID($request->getAnimeID());
        return $response;
    }


}