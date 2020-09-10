<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Anime;
use App\Entity\Image;

use App\Repository\AnimeRepository;
use App\Repository\ImageRepository;
use App\Request\CreateImageRequest;

use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use App\Request\GetByIdRequest;
use App\Request\DeleteRequest;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;

use App\Request\UpdateImageRequest;

class ImageManager
{
    private $entityManager;
    private $imageRepository;
    private $autoMapping;
    private $animeRepository;

    public function __construct(EntityManagerInterface $entityManagerInterface,
    ImageRepository $imageRepository, AutoMapping $autoMapping, AnimeRepository $animeRepository )
    {
        $this->entityManager = $entityManagerInterface;
        $this->imageRepository=$imageRepository;
        $this->autoMapping = $autoMapping;
        $this->animeRepository=$animeRepository;
    }

    public function create(CreateImageRequest $request)
    {
        $imageEntity = $this->autoMapping->map(CreateImageRequest::class, Image::class, $request);
        $this->entityManager->persist($imageEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $imageEntity;
    }
    public function getAll()
    {
        $data = $this->imageRepository->getAll();

        return $data;
    }

    public function getImagesByAnimeID(GetByIdRequest $request)
    {
        $data = $this->imageRepository->getImagesByAnimeId($request->getId());

        return $data;
    }
    
    
    public function delete(DeleteRequest $request)
    {
        $image = $this->imageRepository->getImageById($request->getId());
        if (!$image ) {
           // return new Response(['data'=>'this project  is not found']);
          
        } 
         else{   

            $this->entityManager->remove($image);
            $this->entityManager->flush();
         }
         return $image;
    }

    public function update(UpdateImageRequest $request)
    {
        /*if($request->animeID){
            $anime= $this->entityManager->getRepository(Anime::class)
                ->find($request->animeID);
            $request->setAnimeID($anime);

        }*/
        $imageEntity = $this->imageRepository->getImageById($request->getId());

        if (!$imageEntity) {

        } else {
            $imageEntity = $this->autoMapping->mapToObject(UpdateImageRequest::class,
                Image::class, $request, $imageEntity);

            $this->entityManager->flush();
            return $imageEntity;
        }
    }

}
