<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Comment;
use App\Repository\CommentRepository;
use App\Request\CreateCommentRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Flex\Response;
use App\Request\DeleteRequest;
use App\Request\UpdateCommentRequest;
use App\Response\UpdateCommentResponse;
use App\Request\GetByIdRequest;

class CommentManager
{
    private $entityManager;
    private $commentRepository;
    private $autoMapping;   
   

    public function __construct(EntityManagerInterface $entityManagerInterface,
    CommentRepository $commentRepository, AutoMapping $autoMapping )
    {
        $this->entityManager      = $entityManagerInterface;
        $this->commentRepository  = $commentRepository;
        $this->autoMapping        = $autoMapping;
    }
    public function create(CreateCommentRequest $request)
    {
        $commentEntity = $this->autoMapping->map(CreateCommentRequest::class, Comment::class, $request);

        $this->entityManager->persist($commentEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $commentEntity;
    }

    public function update(UpdateCommentRequest $request)
    {
        $commentEntity = $this->commentRepository->find($request->getId());
        
        if (!$commentEntity) {

        } else {
            $commentEntity = $this->autoMapping->mapToObject(UpdateCommentRequest::class, Comment::class, $request, $commentEntity);
            $this->entityManager->flush();
        }
        return $commentEntity;
    }

    public function delete(DeleteRequest $request)
    {
        $comment = $this->commentRepository->find($request->getId());
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
        return $result = $this->commentRepository->find($request->getId());
    }

    public function getAll($animeId)
    {
        $comments = $this->commentRepository->getAll($animeId);

        return $comments;
    }

    public function getCommentsByAnimeId(GetByIdRequest $request)
    {
        $data = $this->commentRepository->getCommentsByAnimeId($request->getId());

        return $data;
    }
}