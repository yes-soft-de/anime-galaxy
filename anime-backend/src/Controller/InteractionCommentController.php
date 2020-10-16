<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateInteractionCommentRequest;
use App\Request\UpdateInteractionCommentRequest;
use App\Service\InteractionCommentService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class InteractionCommentController extends BaseController
{
    private $interactionService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, InteractionCommentService $interactionService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("interactionComment", name="createInteractionComment", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateInteractionCommentRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->interactionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/interactionComment", name="updateinteractionComment", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionCommentRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->interactionService->update($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/interactionComment/{commentID}", name="getAllInteractionCommentWithAllUsersByCommentID", methods={"GET"})
     * @param $commentID
     * @return JsonResponse
     */
    public function getAll($commentID)
    {
        $result = $this->interactionService->getAll($commentID);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/interactionComment/{commentID}/{userID}", name="getAllInterActionWithUserByCommentIDAndUserID", methods={"GET"})
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
