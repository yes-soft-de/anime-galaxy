<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\CommentEpisode;
use App\Manager\CommentEpisodeManager;
use App\Request\UpdateGradeRequest;
use App\Response\CreateCommentEpisodeResponse;
use App\Response\UpdateCommentEpisodeResponse;
use App\Response\GetCommentEpisodeByIdResponse;
use App\Response\GetCommentsEpisodeResponse;

class CommentEpisodeService
{
    private $commentEpisodeManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    public function __construct(CommentEpisodeManager $commentEpisodeManager, AutoMapping $autoMapping,
 GradeService $gradeService, UpdateGradeRequest $updateGradeRequest)
    {
        $this->commentEpisodeManager =$commentEpisodeManager;
        $this->autoMapping = $autoMapping;
        $this->gradeService = $gradeService;
        $this->updateGradeRequest = $updateGradeRequest;
    }
  
    public function create($request)
    {  
        $commentManager = $this->commentEpisodeManager->create($request);

        $response = $this->autoMapping->map(CommentEpisode::class, CreateCommentEpisodeResponse::class,
            $commentManager);

        if($response != null)
        {
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
        $result = $this->commentEpisodeManager->getCommentById($request);

        return $this->autoMapping->map(CommentEpisode::class, GetCommentEpisodeByIdResponse::class, $result);
    }

    public function getAll($episodeID)
    {
        $response = [];
        $result = $this->commentEpisodeManager->getAll($episodeID);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(CommentEpisode::class, GetCommentsEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function getCommentsByEpisodeId($request)
    {
        $response = [];
        $result = $this->commentEpisodeManager->getCommentsByEpisodeId($request);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetCommentsEpisodeResponse::class, $row);
        }
        return $response;
    }
}