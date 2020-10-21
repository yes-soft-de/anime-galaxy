<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateEpisodeRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateEpisodeRequest;
use App\Service\EpisodeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\HttpFoundation\Response;
class EpisodeController extends BaseController
{
    private $episodeService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, EpisodeService $episodeService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->episodeService = $episodeService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("/episode", name="createEpisode", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, CreateEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->episodeService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/episode", name="updateEpisode", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateEpisodeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->episodeService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/episode/{id}", name="getEpisodeById", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getEpisodeById(Request $request)
    {
        $request = new GetByIdRequest($request->get('id'));
        $result = $this->episodeService->getEpisodeById($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/animeEpisodes/{animeID}", name="getEpisodeByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getEpisodeByAnimeId($animeID)
    {
        $result = $this->episodeService->getEpisodesByAnimeId($animeID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/animeEpisodes/{animeID}/{seasonNumber}", name="getEpisodesByAnimeAndSeason", methods={"GET"})
     * @param $animeID
     * @param $seasonNumber
     * @return JsonResponse
     */
    public function getEpisodesByAnimeAndSeason($animeID, $seasonNumber)
    {
        $result = $this->episodeService->getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/episode/{id}", name="deleteEpisode", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->episodeService->delete($request);

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("episodesComingSoon", name="getAllEpisodesComingSoon", methods={"GET"})
     * @return JsonResponse
     */
    public function getAllComingSoon()
    {
        $result = $this->episodeService->getAllComingSoon();

        return $this->response($result, self::FETCH);
    }
}
