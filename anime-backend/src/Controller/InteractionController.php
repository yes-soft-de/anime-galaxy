<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateInteractionRequest;
use App\Request\UpdateInteractionRequest;
use App\Service\InteractionService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class InteractionController extends BaseController
{
    private $interactionService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, InteractionService $interactionService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("interaction", name="createInteraction", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateInteractionRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->interactionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("interaction", name="updateInteraction", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

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
