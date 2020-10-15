<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateInteractionCommentEpisodeRequest;
use App\Request\UpdateInteractionCommentEpisodeRequest;
use App\Service\InteractionCommentEpisodeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;


class InteractionCommentEpisodeController extends BaseController
{
    private $interactionService;
    private $autoMapping;

    public function __construct( SerializerInterface $serializer, InteractionCommentEpisodeService $interactionService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
    }

      /**
     * @Route("interactionCommentEpisode", name="createInteractionCommentEpisode", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateInteractionCommentEpisodeRequest::class, (object) $data);

        $result = $this->interactionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("interactionCommentEpisode", name="updateinteractionCommentEpisode", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionCommentEpisodeRequest::class, (object) $data);

        $result = $this->interactionService->update($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/interactionCommentEpisode/{commentID}", name="getAllInteractionCommentEpisodeWithAllUsersByCommentID", methods={"GET"})
     * @param $commentID
     * @return JsonResponse
     */
    public function getAll($commentID)
    {
        $result = $this->interactionService->getAll($commentID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/interactionCommentEpisode/{commentID}/{userID}", name="getAllInterActionWithUserByCommentIDAndUserID", methods={"GET"})
     * @param $commentID
     * @param $userID
     * @return JsonResponse
     */
    public function getInteractionWithUser($commentID, $userID)
    {
        $result = $this->interactionService->getInteractionWithUser($commentID, $userID);
        return $this->response($result, self::FETCH);
    }
}