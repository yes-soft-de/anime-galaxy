<?php

namespace App\Controller;


use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\RatingEpisodeService;
use App\Request\CreateRatingEpisodeRequest;
use App\Request\UpdateRatingEpisodeRequest;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\SerializerInterface;

class RatingEpisodeController extends BaseController
{
    private $ratingService;
    private $autoMapping;

    /**
     * RatingController constructor.
     * @param RatingEpisodeService $ratingService
     * @param AutoMapping $autoMapping
     */
    public function __construct(RatingEpisodeService $ratingService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->ratingService = $ratingService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("ratingEpisode", name="createRatingEpisode", name="createRatingEpisode",methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateRatingEpisodeRequest::class,(object)$data);
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