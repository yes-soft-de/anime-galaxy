<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateCommentEpisodeRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateCommentEpisodeRequest;
use App\Service\CommentEpisodeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\HttpFoundation\Response;
class CommentEpisodeController extends BaseController
{
    private $commentEpisodeService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, CommentEpisodeService $commentEpisodeService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->commentEpisodeService = $commentEpisodeService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("commentEpisode", name="createCommentEpisode",methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateCommentEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->commentEpisodeService->create($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/commentEpisode", name="updateCommentEpisode",methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateCommentEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->commentEpisodeService->update($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/commentEpisode/{ID}", name="deleteCommenEpisode",methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('ID'));

        $result = $this->commentEpisodeService->delete($request);

        return $this->response("Deleted Success", self::DELETE);
    }

    /**
     * @Route("/commentEpisode/{ID}", name="getCommentEpisodeByID",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getCommentById(Request $request)
    {
        $request = new GetByIdRequest($request->get('ID'));
        $result = $this->commentEpisodeService->getCommentById($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/commentsEpisode/{episodeID}", name="getAllcommentsForEpisode",methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAll($episodeID)
    {
        $result = $this->commentEpisodeService->getAll($episodeID);

        return $this->response($result, self::FETCH);
    }

}
