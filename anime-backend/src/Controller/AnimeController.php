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

class AnimeController extends BaseController
{
    private $animeService;
    private $autoMapping;

    /**
     * AnimeController constructor.
     * @param AnimeService $animeService
     * @param AutoMapping $autoMapping
     */
    public function __construct(AnimeService $animeService, AutoMapping $autoMapping)
    {
        $this->animeService = $animeService;
        $this->autoMapping = $autoMapping;
    }


    /**
     * @Route("/anime", name="createAnime", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateAnimeRequest::class, (object)$data);
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
     * @Route("/category/{id}", name="getAllAnimeByCategory", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getByCategoryId(Request $request)
    {
        $request = new GetByIdRequest($request->get('id'));
        $result = $this->animeService->getAnimeByCategoryId($request);
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
        //$id = $request->get('id');
        $request = $this->autoMapping->map(\stdClass::class, UpdateAnimeRequest::class, (object)$data);
        //$request->setId($id);
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
        return $this->response("",self::DELETE);
    }
}