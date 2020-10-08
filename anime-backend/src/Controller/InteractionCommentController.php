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


class InteractionCommentController extends BaseController
{
    private $interactionService;
    private $autoMapping;

    public function __construct( SerializerInterface $serializer, InteractionCommentService $interactionService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->interactionService = $interactionService;
        $this->autoMapping = $autoMapping;
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

        $result = $this->interactionService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("interactionComment", name="updateinteractionComment", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateInteractionCommentRequest::class, (object) $data);

        $result = $this->interactionService->update($request);

        return $this->response($result, self::UPDATE);
    }
}
