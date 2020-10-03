<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Comment;
use App\Manager\CommentManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateCommentResponse;
use App\Response\UpdateCommentResponse;
use App\Response\GetCommentByIdResponse;
use App\Response\GetCommentsResponse;

class CommentService
{
    private $commentManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    public function __construct(CommentManager $commentManager, AutoMapping $autoMapping, GradeService $gradeService,
 UpdateGradeRequest $updateGradeRequest)
    {
        $this->commentManager =$commentManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
    }
  
    public function create($request)
    {  
        $commentManager = $this->commentManager->create($request);

        $response = $this->autoMapping->map(Comment::class, CreateCommentResponse::class,
            $commentManager);

        if($response != null)
        {
            $this->updateGradeRequest->setUserID($response->getUserID());
            $this->updateGradeRequest->setPoints(2);

            $this->gradeService->update($this->updateGradeRequest);
        }

        return $response;
    }

    public function update($request)
    {
        $commentResult = $this->commentManager->update($request);

        return $this->autoMapping->map(Comment::class, UpdateCommentResponse::class, $commentResult);
    }

    public function delete($request)
    {
        $result = $this->commentManager->delete($request);

        $response = $this->autoMapping->map(Comment::class, GetCommentByIdResponse::class, $result);
    
        if(!$response)
        {
           return null;
        }
        else
        {
            return $response;
        }
    }

    public function getCommentById($request)
    {
        $result = $this->commentManager->getCommentById($request);

        return $this->autoMapping->map(Comment::class, GetCommentByIdResponse::class, $result);
    }

    public function getAll($animeId)
    {
        $response = [];
        $result = $this->commentManager->getAll($animeId);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Comment::class, GetCommentsResponse::class, $row);
        }

        return $response;
    }

    public function getCommentsByAnimeId($request)
    {
        $response = [];
        $result = $this->commentManager->getCommentsByAnimeId($request);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetCommentsResponse::class, $row);
        }
        return $response;
    }
}