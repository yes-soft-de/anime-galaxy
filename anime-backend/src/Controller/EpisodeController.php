<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Service\EpisodeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class EpisodeController extends BaseController
{
    private $episodeService;
    private $autoMapping;

    public function __construct(SerializerInterface $serializer, EpisodeService $episodeService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->episodeService = $episodeService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/episode", name="createEpisode", methods={"POST"})
     * @param Request $request
     * @return Response
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(\stdClass::class, CreateArticleRequest::class, (object)$data);

        $result = $this->articleService->create($request);

        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/articles/{id}", name="updateArticle", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $id = $request->get('id');
        $request = $this->autoMapping->map(\stdClass::class, UpdateArticleRequest::class, (object)$data);
        $request->setId($id);
        $request->setArticle($request->getArticle('article'));
        $result = $this->articleService->update($request);
        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/articles/{id}", name="getArticleById", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getArticleById(Request $request)
    {
        $request = new GetByIdRequest($request->get('id'));
        $result = $this->articleService->getArticleById($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/articles", name="getAllArticles", methods={"GET"})
     * @return JsonResponse
     */
    public function getAll()
    {
        $result = $this->articleService->getAll();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/articles/{id}", name="deleteArticle", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->articleService->delete($request);
        return $this->response("",self::DELETE);
    }
}