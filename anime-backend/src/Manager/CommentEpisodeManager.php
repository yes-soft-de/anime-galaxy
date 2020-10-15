<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\CommentEpisode;
use App\Repository\CommentEpisodeRepository;
use App\Request\CreateCommentEpisodeRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\DeleteRequest;
use App\Request\UpdateCommentEpisodeRequest;
use App\Request\GetByIdRequest;

class CommentEpisodeManager
{
    private $entityManager;
    private $commentEpisodeRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface,
    CommentEpisodeRepository $commentEpisodeRepository, AutoMapping $autoMapping )
    {
        $this->entityManager             = $entityManagerInterface;
        $this->commentEpisodeRepository  = $commentEpisodeRepository;
        $this->autoMapping               = $autoMapping;
    }
    public function create(CreateCommentEpisodeRequest $request)
    {
        $commentEntity = $this->autoMapping->map(CreateCommentEpisodeRequest::class, CommentEpisode::class, $request);
        $commentEntity->setCreationDate();

        $this->entityManager->persist($commentEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $commentEntity;
    }

    public function update(UpdateCommentEpisodeRequest $request)
    {
        $commentEntity = $this->commentEpisodeRepository->find($request->getId());
        
        if (!$commentEntity) {

        } else {
            $commentEntity = $this->autoMapping->mapToObject(UpdateCommentEpisodeRequest::class, CommentEpisode::class, $request, $commentEntity);
            $this->entityManager->flush();
        }
        return $commentEntity;
    }

    public function delete(DeleteRequest $request)
    {
        $comment = $this->commentEpisodeRepository->find($request->getId());
        if (!$comment ) {
                  
        } 
         else{   

            $this->entityManager->remove($comment);
            $this->entityManager->flush();
         }
         return $comment;
    }

    public function getCommentById(GetByIdRequest $request)
    {
        return $result = $this->commentEpisodeRepository->getCommentById($request->getId());
    }

    public function getAll($Episode)
    {
        return $this->commentEpisodeRepository->getAll($Episode);
    }

    public function getCommentsByEpisodeId(GetByIdRequest $request)
    {
        return $this->commentEpisodeRepository->getCommentsByEpisodeId($request->getId());
    }
}