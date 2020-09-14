<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\CreateImageRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateImageRequest;
use App\Service\ImageService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class ImageController extends BaseController
{
    private $imageService;
    private $autoMapping;

    /**
     * ImageController constructor.
     * @param ImageService $imageService
     * @param AutoMapping $autoMapping
     */
    public function __construct(ImageService $imageService, AutoMapping $autoMapping)
    {
        $this->imageService = $imageService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/image", name="createImage", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class,CreateImageRequest::class,(object)$data);
        $result = $this->imageService->create($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/image", name="getImages", methods={"GET"})
     */
    public function getAll()
    {
        $result = $this->imageService->getAll();
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/image/{animeId}", name="getImageByAnimeId", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getByAnimeId(Request $request)
    {
        $request = new GetByIdRequest($request->get('animeId'));
        $result = $this->imageService->getImagesByAnimeId($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/image/{id}", name="deleteImageById", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->imageService->delete($request);
        return $this->response("",self::DELETE);
    }

    /**
     * @Route("/image", name="updateImage", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        //$id = $request->get('id');
        $request = $this->autoMapping->map(\stdClass::class, UpdateImageRequest::class, (object) $data);
        //$request->setId($id);
        $result = $this->imageService->update($request);
        return $this->response($result, self::UPDATE);
    }
}