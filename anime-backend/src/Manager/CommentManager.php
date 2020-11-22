<?php
namespace App\Manager;

use App\AutoMapping;
use App\Entity\Comment;
use App\Repository\CommentRepository;
use App\Request\CreateCommentRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateCommentRequest;
use Doctrine\ORM\EntityManagerInterface;

class CommentManager
{
    private $entityManager;
    private $commentRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManagerInterface,
        CommentRepository $commentRepository, AutoMapping $autoMapping) {
        $this->entityManager = $entityManagerInterface;
        $this->commentRepository = $commentRepository;
        $this->autoMapping = $autoMapping;
    }
    public function create(CreateCommentRequest $request)
    {
        $commentEntity = $this->autoMapping->map(CreateCommentRequest::class, Comment::class, $request);
        $commentEntity->setCreationDate();

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
        if (!$comment) {

        } else {

            $this->entityManager->remove($comment);
            $this->entityManager->flush();
        }
        return $comment;
    }

    public function getCommentById(GetByIdRequest $request)
    {
        // return $result = $this->commentRepository->find($request->getId());
        return $result = $this->commentRepository->getCommentById($request->getId());
    }

    public function getAll($animeId)
    {
        return $this->commentRepository->getAll($animeId);
    }

    public function commentsNumber($userID)
    {
        return $this->commentRepository->commentsNumber($userID);
    }

    public function getCommentsByAnimeId(GetByIdRequest $request)
    {
        return $this->commentRepository->getCommentsByAnimeId($request->getId());
    }

    public function getFollowersComments($userID)
    {
        $date = [];
        for ($i = 1; $i <= 7; $i++) {
            $date[] = date('Y-m-d', strtotime('-' . $i . ' day'));
        }

        return $result = $this->commentRepository->getFollowersComments($userID, $date);
    }

    public function getCommentsByUserId($userID)
    {
        return $this->commentRepository->getCommentsByUserId($userID);
    }
}
