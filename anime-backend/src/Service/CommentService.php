<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\Comment;
use App\Manager\CommentManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateCommentResponse;
use App\Response\GetCommentByIdResponse;
use App\Response\GetCommentsResponse;
use App\Response\UpdateCommentResponse;
use App\Response\GetcommentsNumberResponse;

class CommentService
{
    private $commentManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;
    private $interactionService;

    public function __construct(CommentManager $commentManager, AutoMapping $autoMapping, GradeService $gradeService,
        UpdateGradeRequest $updateGradeRequest, InteractionCommentService $interactionService) {
        $this->commentManager = $commentManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
        $this->interactionService = $interactionService;
    }

    public function create($request)
    {
        $commentManager = $this->commentManager->create($request);

        $response = $this->autoMapping->map(Comment::class, CreateCommentResponse::class,
            $commentManager);

        if ($response != null) {
            $this->updateGradeRequest->setUserID($response->getUserID());
            $this->updateGradeRequest->setRequestSender("comment");

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

        if (!$response) {
            return null;
        } else {
            return $response;
        }
    }

    public function getCommentById($request)
    {
        $result = $this->commentManager->getCommentById($request);

        $love = $this->interactionService->loved($request);
        $like = $this->interactionService->like($request);
        $dislike = $this->interactionService->dislike($request);
        foreach ($result as $row) {
            $response = $this->autoMapping->map('array', GetCommentByIdResponse::class, $row);
        }
        if($response){
            $response->interactions['love'] = $love;
            $response->interactions['like'] = $like;
            $response->interactions['dislike'] = $dislike;
        }
        return $response;
    }

    public function getAll($animeId)
    {
        $response = [];
        $result = $this->commentManager->getAll($animeId);

        foreach ($result as $row) {
            $row['commentInteractions'] = [
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id']),
            ];
            $response[] = $this->autoMapping->map('array', GetCommentsResponse::class, $row);
        }

        return $response;
    }
    public function commentsNumber($userID)
    {
        $response = [];
        $result = $this->commentManager->commentsNumber($userID);
        foreach ($result as $row) {
             $response = $this->autoMapping->map('array', GetcommentsNumberResponse::class, $row);
        }
        return $response;
    }

    public function getCommentsByAnimeId($request)
    {

        $response = [];
        $result = $this->commentManager->getCommentsByAnimeId($request);

        foreach ($result as $row) {
            $request->setID($row['id']);
            $row['commentInteractions'] = [
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id']),
                'isLoved' => $this->interactionService->checkUserLoved($request)
            ];

            $response[] = $this->autoMapping->map('array', GetCommentsResponse::class, $row);
        }
        return $response;
    }

    public function getFollowersComments($friendID)
    {
        return  $this->commentManager->getFollowersComments($friendID); 
    
    }
}
