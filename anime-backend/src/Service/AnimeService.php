<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Anime;
use App\Manager\AnimeManager;
use App\Manager\ImageManager;
use App\Request\UpdateAnimeRequest;
use App\Request\UpdateImageRequest;
use App\Response\CreateAnimeResponse;
use App\Response\GetAnimeByIdResponse;
use App\Response\GetAnimeResponse;
use App\Response\UpdateAnimeResponse;

class AnimeService
{
    private $animeManager;
    private $autoMapping;
    private $imageManager;

    /**
     * AnimeService constructor.
     * @param AnimeManager $animeManager
     * @param AutoMapping $autoMapping
     * @param ImageManager $imageManager
     */
    public function __construct(AnimeManager $animeManager, AutoMapping $autoMapping,
 ImageManager $imageManager)
    {
        $this->animeManager = $animeManager;
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
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
            $response[] = $this->autoMapping->map(Anime::class, GetAnimeResponse::class, $row);
        }
        return $response;
    }

    public function getAnimeById($request)
    {
        $result = $this->animeManager->getAnimeById($request);
        $response = $this->autoMapping->map(Anime::class, GetAnimeByIdResponse::class, $result);
        return $response;
    }

    public function update($request)
    {
        $animeResult = $this->animeManager->update($request);
        $response = $this->autoMapping->map(Anime::class, UpdateAnimeResponse::class, $animeResult);

        /*$animeImage = new UpdateImageRequest();
        $animeImage->image = $response->getMainImage();
        $animeImage->animeID = $response->getId();
        $animeResult = $this->imageManager->update($animeImage);*/
        $response->setName($request->getName());
        $response->setMainImage($request->getMainImage());
        return $response;
    }

    public function deleteAnime($request)
    {
        $animeResult = $this->animeManager->delete($request);
        if($animeResult==null)
        {
            return null;
        }
        $response = $this->autoMapping->map(Anime::class, GetAnimeByIdResponse::class, $animeResult);
        return $response;
    }
}