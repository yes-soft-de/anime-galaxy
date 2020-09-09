<?php

namespace App\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\WatchListService;
use App\Request\CreateWatchListRequest;
use App\Request\UpdateWatchListRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;

class WatchListController extends BaseController
{
    private $watchListService;
    private $autoMapping;


    /**
     * watchListController constructor.
     * @param WatchListService $watchListService
     */
    public function __construct(WatchListService $watchListService,AutoMapping $autoMapping)
    {
        $this->watchListService = $watchListService;
        $this->autoMapping    = $autoMapping;
    }


    /**
     * @Route("/watchList/{userId}/{animeId}", name="watchList", name="createWatchList",methods={"POST"})
     */
    public function create(Request $request, $userId , $animeId)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateWatchListRequest::class,(object)$data);
         $request->setUserId($userId);
         $request->setAnimeId($animeId);
         $result = $this->watchListService->create($request, $userId , $animeId);
         return $this->response($result, self::CREATE);
    }


    /**
     * @Route("/watchList/{id}/{userId}/{animeId}", name="updateWatchList",methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request, $userId, $animeId)
    {
      
        $data = json_decode($request->getContent(), true);
        $id = $request->get('id');
        $request = $this->autoMapping->map(\stdClass::class, UpdateWatchListRequest::class, (object) $data);
        $request->setId($id);
        $request->setUserId($userId);
        $request->setAnimeId($animeId);
        $result = $this->watchListService->update($request);
        return $this->response($result, self::UPDATE);
    }


     /**
     * @Route("/watchList/{id}", name="deleteWatchList",methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->watchListService->delete($request);

        return $this->response("Deleted Success", self::DELETE);

    }


    /**
     * @Route("/watchList/{id}", name="getWatchListById",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getWatchListById(Request $request)
    {
        $request=new GetByIdRequest($request->get('id'));
        $result = $this->watchListService->getWatchListById($request);
        
        return $this->response($result, self::FETCH);
    }


     /**
     * @Route("/watchListsAnime/{animeID}", name="getAllWatchListsByAnimeID",methods={"GET"})
     * @return JsonResponse
     */
    public function getAllWatchListsByAnimeID($animeID)
    {
        $result = $this->watchListService->getAllWatchListsByAnimeID($animeID);
        return $this->response($result, self::FETCH);
    }  
    
    
    /**
     * @Route("/watchListsUser/{userID}", name="getAllWatchListsByUserID",methods={"GET"})
     * @return JsonResponse
     */
    public function getAllWatchListsByUserID($userID)
    {
        $result = $this->watchListService->getAllWatchListsByUserID($userID);
        return $this->response($result, self::FETCH);
    }  
}
