<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\Anime;
use App\Manager\AnimeManager;
use App\Response\CreateAnimeResponse;
use App\Response\GetAnimeByCategoryResponse;
use App\Response\GetAnimeByIdResponse;
use App\Response\GetAnimeCommingSoonResponse;
use App\Response\GetAnimeResponse;
use App\Response\GetHighestRatedAnimeByUserResponse;
use App\Response\GetHighestRatedAnimeResponse;
use App\Response\GetMaybeYouLikeResponse;
use App\Response\UpdateAnimeResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class AnimeService
{
    private $animeManager;
    private $autoMapping;
    private $imageService;
    private $commentService;
    private $interactionService;
    private $params;

    public function __construct(AnimeManager $animeManager, AutoMapping $autoMapping, ImageService $imageService, CommentService $commentService,
        InteractionService $interactionService, ParameterBagInterface $params) {
        $this->animeManager = $animeManager;
        $this->autoMapping = $autoMapping;
        $this->imageService = $imageService;
        $this->commentService = $commentService;
        $this->interactionService = $interactionService;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function createAnime($request)
    {
        $animeResult = $this->animeManager->create($request);
        return $this->autoMapping->map(Anime::class, CreateAnimeResponse::class, $animeResult);
    }

    public function getAnimeById($request)
    {
        /** @var $response GetAnimeByIdResponse*/
        $response = [];

        $result = $this->animeManager->getAnimeById($request);

        $resultImg = $this->imageService->getImagesByAnimeID($request);
        $resultComments = $this->commentService->getCommentsByAnimeId($request);
        $love = $this->interactionService->loved($request);
        $like = $this->interactionService->like($request);
        $dislike = $this->interactionService->dislike($request);

        foreach ($result as $row)
        {
            $row['mainImage'] = $this->specialLinkCheck($row['specialLink']).$row['mainImage'];

            $response = $this->autoMapping->map('array', GetAnimeByIdResponse::class, $row);
        }
        if($result)
        {
        $response->setImages($resultImg);
        $response->setComments($resultComments);
        $response->interactions['love'] = $love;
        $response->interactions['like'] = $like;
        $response->interactions['dislike'] = $dislike;
        $response->interactions['isLoved'] = $this->interactionService->checkUserLoved($request);
        }
        return $response;
    }

    public function getAllAnime()
    {
        /** @var $response GetAnimeResponse*/
        $result = $this->animeManager->getAllAnime();
        $response = [];
        
        foreach ($result as $row)
        {
            $row['mainImage'] = $this->specialLinkCheck($row['specialLink']).$row['mainImage'];

            $row['interaction']=[
            'love' => $this->interactionService->lovedAll($row['id']),
            'like' => $this->interactionService->likeAll($row['id']),
            'dislike' => $this->interactionService->dislikeAll($row['id'])
            ];
            $response[] = $this->autoMapping->map('array', GetAnimeResponse::class, $row);

        }
        return $response;
    }

    public function getAnimeByCategoryID($categoryID)
    {
        $result = $this->animeManager->getByCategoryID($categoryID);
        $response = [];
        
        foreach ($result as $row)
        {
            $row['mainImage'] = $this->specialLinkCheck($row['specialLink']).$row['mainImage'];

            $row['interaction']=[
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id']),
            ];
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
        if ($animeResult == null) {
            return null;
        }
        return $this->autoMapping->map(Anime::class, GetAnimeByIdResponse::class, $animeResult);

    }

    public function getHighestRatedAnime()
    {
        $response = [];
        $result = $this->animeManager->getHighestRatedAnime();

        foreach ($result as $row)
        {
            $row['animeMainImage'] = $this->specialLinkCheck($row['specialLink']).$row['animeMainImage'];

            $response[] = $this->autoMapping->map('array', GetHighestRatedAnimeResponse::class, $row);
        }

        return $response;
    }

    public function getHighestRatedAnimeByUser($userID)
    {
        $response = [];
        $result = $this->animeManager->getHighestRatedAnimeByUser($userID);

        foreach ($result as $row)
        {
            $row['animeMainImage'] = $this->specialLinkCheck($row['specialLink']).$row['animeMainImage'];

            $response[] = $this->autoMapping->map('array', GetHighestRatedAnimeByUserResponse::class, $row);
        }

        return $response;
    }

    public function getAllComingSoon()
    {
        /** @var $response */
       
        $result = $this->animeManager->getAllComingSoon();
        $response = [];
        
        foreach ($result as $row)
        {
            $row['mainImage'] = $this->specialLinkCheck($row['specialLink']).$row['mainImage'];

            $response[] = $this->autoMapping->map('array', GetAnimeCommingSoonResponse::class, $row);

        }
        return $response;
    }

    public function searchMyArray($arrays, $key, $search)
    {       
        $count = 0;

        foreach ($arrays as $object) {
            if (is_object($object)) {
                $object = get_object_vars($object);
            }
            if (array_key_exists($key, $object) && $object[$key] == $search) {
                $count++;
            }

        }
        return $count;
    }

    public function getMaybeYouLike($userID)
    {
        /** @var $response */
       $response = [];

       $result = $this->animeManager->getAnimeFavourite($userID);
       
       $result1 = $this->animeManager->getAnimeByFavouriteCategory($userID);

       foreach($result1 as $res)
       {
           $res['animeMainImage'] = $this->specialLinkCheck($res['specialLink']).$res['animeMainImage'];

          if (!$this->searchMyArray($result, 'id', $res['id']))
          {
              $response[] = $this->autoMapping->map('array', GetMaybeYouLikeResponse::class, $res);
          }
        }
        return $response;
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool) {
            return $this->params;
        }
    }
}
