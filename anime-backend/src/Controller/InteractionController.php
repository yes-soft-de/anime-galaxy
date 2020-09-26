<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\InteractionService;
use App\Request\CreateInteractionRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;
use App\Request\UpdateInteractionRequest;

class InteractionController extends BaseController
{
    private $interactionService;
    private $autoMapping;

    /**
     * InteractionController constructor.
     * @param InteractionService $interactionService
     * @param AutoMapping $autoMapping
     */
    public function __construct(InteractionService $interactionService, AutoMapping $autoMapping)
    {
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/interaction/{userID}/{animeID}/{type}", name="createInteraction", name="createInteraction",methods={"POST"})
     * @param Request $request
     * @param $userID
     * @param $animeID
     * @param $type
     * @return JsonResponse
     */
    public function create(Request $request, $userID , $animeID, $type)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateInteractionRequest::class,(object)$data);
         $request->setUserID($userID);
         $request->setAnimeID($animeID);
         $request->setType($type);
         $result = $this->interactionService->create($request, $userID , $animeID, $type);
         return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/interaction/{userID}/{animeID}/{type}", name="updateInteraction", methods={"PUT"})
     * @param Request $request
     * @param $userID
     * @param $animeID
     * @param $type
     * @return JsonResponse|Response
     */
    public function update(Request $request, $userID, $animeID, $type)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionRequest::class, (object) $data);
        $request->setUserID($userID);
        $request->setAnimeID($animeID);
        $request->setType($type);
        $result = $this->interactionService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/interaction/{animeID}", name="getAllInteractionWithAllUsersByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAll($animeID)
    {
        $result = $this->interactionService->getAll($animeID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/interaction/{animeID}/{userID}", name="getAllInterActionWithUserByAnimeIDAndUserID", methods={"GET"})
     * @param $animeID
     * @param $userID
     * @return JsonResponse
     */
    public function getInteractionWithUser($animeID, $userID)
    {
        $result = $this->interactionService->getInteractionWithUser($animeID, $userID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/countInteractions/{animeID}", name="countInteractionsByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function countInteractions($animeID)
    {
        $result = $this->interactionService->countInteractions($animeID);
        return $this->response($result, self::FETCH);
    }
}
