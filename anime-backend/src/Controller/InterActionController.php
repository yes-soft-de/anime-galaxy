<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\InterActionService;
use App\Request\CreateInterActionRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;
use App\Request\UpdateInterActionRequest;
class InterActionController extends BaseController
{
    private $interActionService;
    private $autoMapping;


    /**
     * InterActionController constructor.
     * @param InterActionService $interActionService
     */
    public function __construct(InterActionService $interActionService,AutoMapping $autoMapping)
    {
        $this->interActionService = $interActionService;
        $this->autoMapping        = $autoMapping;
    }


    /**
     * @Route("/interaction/{userID}/{animeID}/{type}", name="createInteraction", name="createInteraction",methods={"POST"})
     */
    public function create(Request $request, $userID , $animeID, $type)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateInterActionRequest::class,(object)$data);
         $request->setUserId($userID);
         $request->setAnimeId($animeID);
         $request->setType($type);
         $result = $this->interActionService->create($request, $userID , $animeID, $type);
         return $this->response($result, self::CREATE);
    }


    /**
     * @Route("/interaction/{userID}/{animeID}/{type}", name="updateInteraction",methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request, $userID, $animeID, $type)
    {
      
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInterActionRequest::class, (object) $data);
        $request->setUserId($userID);
        $request->setAnimeId($animeID);
        $request->setType($type);
        $result = $this->interActionService->update($request);
        return $this->response($result, self::UPDATE);
    }



     /**
     * @Route("/interaction/{animeID}", name="getAllinteractionWithAllUsersByAnimeID",methods={"GET"})
     * @return JsonResponse
     */
    public function getAll($animeID)
    {
        $result = $this->interActionService->getAll($animeID);
        return $this->response($result, self::FETCH);
    }


    /**
     * @Route("/interaction/{animeID}/{userID}", name="getAllinterActionWithUserByAnimeIDAndUserID",methods={"GET"})
     * @return JsonResponse
     */
    public function getInterActionwithUser($animeID, $userID)
    {
        $result = $this->interActionService->getInterActionwithUser($animeID, $userID);
        return $this->response($result, self::FETCH);
    }


    /**
     * @Route("/countInteractions/{animeID}", name="countInteractionsByAnimeID",methods={"GET"})
     * @return JsonResponse
     */
    public function countInerActions($animeID)
    {
        $result = $this->interActionService->countInerActions($animeID);
        return $this->response($result, self::FETCH);
    }
}
