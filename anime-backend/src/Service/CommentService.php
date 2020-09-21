<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Comment;
use App\Manager\CommentManager;
use App\Response\CreateCommentResponse;
use App\Response\UpdateCommentResponse;
use Symfony\Component\HttpFoundation\Request;
use App\Response\GetCommentByIdResponse;
use App\Response\GetCommentsResponse;
class CommentService

{
    private $commentManager;
    private $autoMapping;


    public function __construct(CommentManager $commentManager, AutoMapping $autoMapping)
    {
        $this->commentManager =$commentManager;
        $this->autoMapping = $autoMapping;
    }
  
    public function create($request, $userId, $animeId)
    {  
        $request->setUserID($request->getUserID($userId));
        $request->setAnimeID($request->getAnimeID($animeId));
        $commentManager = $this->commentManager->create($request);
        $commentManager->getUserID($userId);
        $commentManager->getAnimeID($animeId);
        $response = $this->autoMapping->map(Comment::class, CreateCommentResponse::class,
            $commentManager);
            
        return $response;
    }

    public function update($request)
    {
        $commentResult = $this->commentManager->update($request);
     
        $response = $this->autoMapping->map(Comment::class, UpdateCommentResponse::class, $commentResult);
        
        return $response;   
    }

    public function delete($request)
    {
        $result = $this->commentManager->delete($request);
        $response = $this->autoMapping->map(Comment::class, GetCommentByIdResponse::class, $result);
    
        if(!$response)
        {
           $error=['error'=>"this comment not found!!!"];
           return $error;
        }
        else{
        return $response;}
          
    }

    public function getCommentById($request)
    {
        $result = $this->commentManager->getCommentById($request);
        $response = $this->autoMapping->map(Comment::class, GetCommentByIdResponse::class, $result);
        return $response;
    }

    public function getAll($animeId)
    {
        $result = $this->commentManager->getAll($animeId);
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Comment::class, GetCommentsResponse::class, $row);
        }

        return $response;
    }

    public function getCommentsByAnimeId($request)
    {
        $result = $this->commentManager->getCommentsByAnimeId($request);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetCommentsResponse::class, $row);
        }
        return $response;
    }
}