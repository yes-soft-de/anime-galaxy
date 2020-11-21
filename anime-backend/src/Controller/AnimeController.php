<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateAnimeRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateAnimeRequest;
use App\Service\AnimeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class AnimeController extends BaseController
{
    private $animeService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, AnimeService $animeService, SerializerInterface $serializer, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->animeService = $animeService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("/anime", name="createAnime", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateAnimeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->animeService->createAnime($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/anime/{id}", name="getAnime", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getAnimeById(Request $request)
    {
        $request = new GetByIdRequest($request->get('id'));
        dd($this->getUserId()));
        $request->setUserID($this->getUserId());

        $result = $this->animeService->getAnimeById($request);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/anime", name="getAllAnime", methods={"GET"})
     * @return JsonResponse
     */
    public function getAll()
    {
        $result = $this->animeService->getAllAnime();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/animeByCategory/{categoryID}", name="getAllAnimeByCategory", methods={"GET"})
     * @param $categoryID
     * @return JsonResponse
     */
    public function getByCategoryID($categoryID)
    {
        $result = $this->animeService->getAnimeByCategoryID($categoryID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/anime", name="updateAnime", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateAnimeRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->animeService->update($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/anime/{id}", name="deleteAnime", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));

        $result = $this->animeService->deleteAnime($request);

        return $this->response("", self::DELETE);
    }

    /**
     * @Route("/getHighestRatedAnime", name="GetHighestRatedAnimeByCategory", methods={"GET"})
     * @return JsonResponse
     */
    public function getHighestRatedAnime()
    {
        $result = $this->animeService->getHighestRatedAnime();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("getHighestRatedAnime/{userID}", name="GetHighestRatedAnimeByUser", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getHighestRatedAnimeByUser($userID)
    {
        $result = $this->animeService->getHighestRatedAnimeByUser($userID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("animeComingSoon", name="getAllAnimeComingSoon", methods={"GET"})
     * @return JsonResponse
     */
    public function getAllComingSoon()
    {
        $result = $this->animeService->getAllComingSoon();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("getMaybeYouLike/{userID}", name="getMaybeYouLike", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getMaybeYouLike($userID)
    {
        $result = $this->animeService->getMaybeYouLike($userID);

        return $this->response($result, self::FETCH);
    }
}
