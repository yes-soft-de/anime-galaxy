<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateFavouriteRequest;
use App\Request\DeleteRequest;
use App\Service\FavouriteService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class FavouriteController extends BaseController
{
    private $favouriteService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, FavouriteService $favouriteService, AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->favouriteService = $favouriteService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("favourite", name="createFavourite", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateFavouriteRequest::class, (object) $data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $result = $this->favouriteService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("favouriteAnime/{animeID}", name="getAllFavouritesByAnimeID", methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAllFavouritesByAnimeID($animeID)
    {
        $result = $this->favouriteService->getAllFavouritesByAnimeID($animeID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("favouriteUser/{userID}", name="getAllFavouritesByUserID", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getAllFavouritesByUserID($userID)
    {
        $result = $this->favouriteService->getAllFavouritesByUserID($userID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("getMayLikeItF/{userID}", name="getMayLikeItF", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getMayLikeIt($userID)
    {
        $result = $this->favouriteService->getMayLikeIt($userID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("favourite/{animeID}/{userID}", name="deleteFavourite", methods={"DELETE"})
     * @param $animeID
     * @param $userID
     * @return JsonResponse
     */
    public function delete($animeID, $userID)
    {
        $result = $this->favouriteService->delete($animeID, $userID);

        return $this->response("", self::DELETE);
    }
}
