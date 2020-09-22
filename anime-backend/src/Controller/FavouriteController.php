<?php

namespace App\Controller;
use App\Entity\Favourite;
use App\Request\CreateFavouriteRequest;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\FavouriteService;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;

class FavouriteController extends BaseController
{
    private $favouriteService;
    private $autoMapping;

    /**
     * watchListController constructor.
     * @param FavouriteService $favouriteService
     * @param AutoMapping $autoMapping
     */
    public function __construct(FavouriteService $favouriteService, AutoMapping $autoMapping)
    {
        $this->favouriteService = $favouriteService;
        $this->autoMapping    = $autoMapping;
    }

    /**
     * @Route("/favourite/{userID}/{animeID}", name="createFavourite", methods={"POST"})
     * @param Request $request
     * @param $userID
     * @param $animeID
     * @return JsonResponse
     */
    public function create(Request $request, $userID , $animeID)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateFavouriteRequest::class,(object)$data);
         $request->setUserID($userID);
         $request->setAnimeID($animeID);
         $result = $this->favouriteService->create($request, $userID , $animeID);
         return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/favourite/{ID}", name="getFavouriteByID", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getFavouriteById(Request $request)
    {
        $request=new GetByIdRequest($request->get('ID'));
        $result = $this->favouriteService->getFavouriteById($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/favouritesAnime/{animeID}", name="getAllFavouritesByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAllFavouritesByAnimeID($animeID)
    {
        $result = $this->favouriteService->getAllFavouritesByAnimeID($animeID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/favouriteUser/{userID}", name="getAllFavouritesByUserID", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getAllFavouritesByUserID($userID)
    {
        $result = $this->favouriteService->getAllFavouritesByUserID($userID);
        return $this->response($result, self::FETCH);
    }  
}
