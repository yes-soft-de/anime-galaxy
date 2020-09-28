<?php

namespace App\Controller;

use App\Request\CreateFavouriteRequest;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\FavouriteService;
use Symfony\Component\Serializer\SerializerInterface;

class FavouriteController extends BaseController
{
    private $favouriteService;
    private $autoMapping;

    public function __construct(FavouriteService $favouriteService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->favouriteService = $favouriteService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("favourite", name="createFavourite", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateFavouriteRequest::class,(object)$data);

         $result = $this->favouriteService->create($request);

         return $this->response($result, self::CREATE);
    }

    /**
     * @Route("favouriteAnime/{animeID}", name="getAllFavouritesByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAllFavouritesByAnimeID($animeID)
    {
        $result = $this->favouriteService->getAllFavouritesByAnimeID($animeID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("favouriteUser/{userID}", name="getAllFavouritesByUserID", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getAllFavouritesByUserID($userID)
    {
        $result = $this->favouriteService->getAllFavouritesByUserID($userID);

        return $this->response($result, self::FETCH);
    }  

}
