<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Anime;
use App\Manager\AnimeManager;
use App\Response\CreateAnimeResponse;
use App\Response\GetAnimeByIdResponse;
use App\Response\GetAnimeResponse;
use App\Response\GetAnimeByCategoryResponse;
use App\Response\UpdateAnimeResponse;

class AnimeService
{
    private $animeManager;
    private $autoMapping;
    private $imageService;
    private $commentService;

    /**
     * AnimeService constructor.
     * @param AnimeManager $animeManager
     * @param AutoMapping $autoMapping
     * @param ImageService $imageService
     * @param CommentService $commentService
     */
    public function __construct(AnimeManager $animeManager, AutoMapping $autoMapping,
 ImageService $imageService, CommentService $commentService)
    {
        $this->animeManager = $animeManager;
        $this->autoMapping = $autoMapping;
        $this->imageService = $imageService;
        $this->commentService = $commentService;
    }

    public function createAnime($request)
    {
        $animeResult = $this->animeManager->create($request);
        $response = $this->autoMapping->map(Anime::class, CreateAnimeResponse::class, $animeResult);
        return $response;
    }

    public function getAllAnime()
    {
        $result = $this->animeManager->getAllAnime();
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetAnimeResponse::class, $row);
        }
        return $response;
    }

    public function getAnimeById($request)
    {
       $resultImg = $this->imageService->getImagesByAnimeID($request);
       $resultComments = $this->commentService->getCommentsByAnimeId($request);
       $result = $this->animeManager->getAnimeById($request);

       foreach ($result as $row)
       {
       $response = $this->autoMapping->map('array', GetAnimeByIdResponse::class, $row);
       }

        $response->setImage($resultImg);
       $response->setComments($resultComments);
        return $response;
    }

    public function getAnimeByCategoryId($request)
    {
        $result = $this->animeManager->getByCategoryId($request);
        $response = [];
        
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetAnimeByCategoryResponse::class, $row);
        }
        return $response;
    }

    public function update($request)
    {
        $animeResult = $this->animeManager->update($request);
        $response = $this->autoMapping->map(Anime::class, UpdateAnimeResponse::class, $animeResult);
        $response->setName($request->getName());
        $response->setMainImage($request->getMainImage());
        return $response;
    }

    public function deleteAnime($request)
    {
        $animeResult = $this->animeManager->delete($request);
        if($animeResult == null)
        {
            return null;
        }
        $response = $this->autoMapping->map(Anime::class, GetAnimeByIdResponse::class, $animeResult);
        return $response;
    }
}