<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateInteractionEpisodeRequest;
use App\Request\UpdateInteractionEpisodeRequest;
use App\Service\InteractionEpisodeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class InteractionEpisodeController extends BaseController
{
    private $interactionService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, InteractionEpisodeService $interactionService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("interactionEpisode", name="createInteractionEpisode", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateInteractionEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->interactionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/interactionEpisode", name="updateInteractionEpisode", methods={"PUT"})
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        
        $result = $this->interactionService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/interactionEpisode/{episodeID}", name="getAllInteractionEpisodeWithAllUsersByEpisodeID", methods={"GET"})
     * @param $episodeID
     * @return JsonResponse
     */
    public function getAll($episodeID)
    {
        $result = $this->interactionService->getAll($episodeID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/interactionEpisode/{episodeID}/{userID}", name="getAllInterActionWithUserByEpisodeIDAndUserID", methods={"GET"})
     * @param $episodeID
     * @param $userID
     * @return JsonResponse
     */
    public function getInteractionWithUser($episodeID, $userID)
    {
        $result = $this->interactionService->getInteractionWithUser($episodeID, $userID);
        return $this->response($result, self::FETCH);
    }

}
