<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\CommentService;
use App\Request\CreateCommentRequest;
use App\Request\UpdateCommentRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;
class CommentController extends BaseController
{

    private $commentService;
    private $autoMapping;


    /**
     * CommentController constructor.
     * @param CommentService $commentService
     */
    public function __construct(CommentService $commentService,AutoMapping $autoMapping)
    {
        $this->commentService = $commentService;
        $this->autoMapping    = $autoMapping;
    }


    /**
     * @Route("/comment/{userId}/{animeId}", name="comment", name="createComment",methods={"POST"})
     */
    public function create(Request $request, $userId , $animeId)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateCommentRequest::class,(object)$data);
         $request->setUserId($userId);
         $request->setAnimeId($animeId);
         $result = $this->commentService->create($request, $userId , $animeId);
         return $this->response($result, self::CREATE);
    }


    /**
     * @Route("/comment/{userId}/{animeId}", name="updateComment",methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request, $userId, $animeId)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateCommentRequest::class, (object) $data);
        $request->setUserId($userId);
        $request->setAnimeId($animeId);
        $result = $this->commentService->update($request);
        return $this->response($result, self::UPDATE);
    }


     /**
     * @Route("/comment/{id}", name="deleteComment",methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->commentService->delete($request);

        return $this->response("Deleted Success", self::DELETE);

    }


    /**
     * @Route("/comment/{id}", name="getCommentById",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getCommentById(Request $request)
    {
        $request=new GetByIdRequest($request->get('id'));
        $result = $this->commentService->getCommentById($request);
        
        return $this->response($result, self::FETCH);
    }


     /**
     * @Route("/comments/{animeId}", name="getAllcommentsForAnime",methods={"GET"})
     * @return JsonResponse
     */
    public function getAll($animeId)
    {
        $result = $this->commentService->getAll($animeId);
        return $this->response($result, self::FETCH);
    }
}
