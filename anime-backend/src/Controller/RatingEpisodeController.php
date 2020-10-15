<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateRatingEpisodeRequest;
use App\Request\UpdateRatingEpisodeRequest;
use App\Service\RatingEpisodeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class RatingEpisodeController extends BaseController
{
    private $ratingService;
    private $autoMapping;
    private $validator;
    /**
     * RatingController constructor.
     * @param RatingEpisodeService $ratingService
     * @param AutoMapping $autoMapping
     */
    public function __construct(ValidatorInterface $validator, RatingEpisodeService $ratingService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->ratingService = $ratingService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("ratingEpisode", name="createRatingEpisode", name="createRatingEpisode",methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateRatingEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->ratingService->create($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("ratingEpisode", name="updateRatingEpisode", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateRatingEpisodeRequest::class, (object) $data);
        $result = $this->ratingService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("ratingEpisode/{episodeID}/{userID}", name="getRatingByEpisodeIDAndUserID", methods={"GET"})
     * @param $EpisodeID
     * @param $userID
     * @return JsonResponse
     */
    public function getRating($episodeID, $userID)
    {
        $result = $this->ratingService->getRating($episodeID, $userID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("ratingEpisode/{episodeID}", name="getAllRatingsByEpisodeID", methods={"GET"})
     * @param $episodeID
     * @return JsonResponse
     */
    public function getAllRatings($episodeID)
    {
        $result = $this->ratingService->getAllRatings($episodeID);

        return $this->response($result, self::FETCH);
    }

}
