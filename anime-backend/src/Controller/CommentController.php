<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\CommentService;
use App\Request\CreateCommentRequest;
use App\Request\UpdateCommentRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class CommentController extends BaseController
{
    private $commentService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, CommentService $commentService,AutoMapping $autoMapping, SerializerInterface $serializer)
    {
        parent::__construct($serializer);
        $this->commentService = $commentService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
    }

    /**
     * @Route("comment", name="comment", name="createComment",methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateCommentRequest::class,(object)$data);
        
         $violations = $this->validator->validate($request);
         if (\count($violations) > 0)
         {
             $violationsString = (string) $violations;
 
             return new JsonResponse($violationsString, Response::HTTP_OK);
         }

         $result = $this->commentService->create($request);
         return $this->response($result, self::CREATE);
    }

    /**
     * @Route("comment", name="updateComment",methods={"PUT"})
     * @param Request $request
     * @return JsonResponse|Response
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateCommentRequest::class, (object) $data);

        $result = $this->commentService->update($request);

        return $this->response($result, self::UPDATE);
    }

     /**
     * @Route("/comment/{ID}", name="deleteComment",methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('ID'));

        $result = $this->commentService->delete($request);

        return $this->response("Deleted Success", self::DELETE);
    }

    /**
     * @Route("/comment/{ID}", name="getCommentByID",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getCommentById(Request $request)
    {
        $request = new GetByIdRequest($request->get('ID'));
        $result  = $this->commentService->getCommentById($request);
        
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/comments/{animeID}", name="getAllcommentsForAnime",methods={"GET"})
     * @param $animeID
     * @return JsonResponse
     */
    public function getAll($animeID)
    {
        $result = $this->commentService->getAll($animeID);

        return $this->response($result, self::FETCH);
    }
}
