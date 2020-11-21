<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\CommentEpisode;
use App\Manager\CommentEpisodeManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateCommentEpisodeResponse;
use App\Response\GetCommentEpisodeByIdResponse;
use App\Response\GetCommentsEpisodeResponse;
use App\Response\UpdateCommentEpisodeResponse;

class CommentEpisodeService
{
    private $commentEpisodeManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;
    private $interactionService;

    public function __construct(CommentEpisodeManager $commentEpisodeManager, AutoMapping $autoMapping,
        GradeService $gradeService, UpdateGradeRequest $updateGradeRequest, InteractionCommentEpisodeService $interactionService) {
        $this->commentEpisodeManager = $commentEpisodeManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
        $this->interactionService = $interactionService;
    }

    public function create($request)
    {
        $commentManager = $this->commentEpisodeManager->create($request);

        $response = $this->autoMapping->map(CommentEpisode::class, CreateCommentEpisodeResponse::class,
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
        $commentResult = $this->commentEpisodeManager->update($request);

        return $this->autoMapping->map(CommentEpisode::class, UpdateCommentEpisodeResponse::class, $commentResult);
    }

    public function delete($request)
    {
        $result = $this->commentEpisodeManager->delete($request);

        $response = $this->autoMapping->map(CommentEpisode::class, GetCommentByIdResponse::class, $result);

        if (!$response) {
            return null;
        } else {
            return $response;
        }
    }

    public function getCommentById($request)
    {
        $response = [];
        $result = $this->commentEpisodeManager->getCommentById($request);

        $love = $this->interactionService->loved($request);
        $like = $this->interactionService->like($request);
        $dislike = $this->interactionService->dislike($request);
        foreach ($result as $row)
        {
        $response =  $this->autoMapping->map('array', GetCommentEpisodeByIdResponse::class, $row);
        }
        $response->interactions['love'] = $love;
        $response->interactions['like'] = $like;
        $response->interactions['dislike'] = $dislike;
        return $response;
    }

    public function getAll($episodeID)
    {
        $response = [];
        $result = $this->commentEpisodeManager->getAll($episodeID);

        foreach ($result as $row) {
            $row['commentInteractions'] = [
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id']),
            ];
            $response[] = $this->autoMapping->map('array', GetCommentsEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function getCommentsByEpisodeId($request)
    {
        $response = [];
        $result = $this->commentEpisodeManager->getCommentsByEpisodeId($request);

        foreach ($result as $row) {
            $request->setId($row['id']);
            $row['commentInteractions'] = [
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id']),
                'isLoved' => $this->interactionService->checkUserLoved($request)
            ];
            $response[] = $this->autoMapping->map('array', GetCommentsEpisodeResponse::class, $row);
        }
        return $response;
    }
}
