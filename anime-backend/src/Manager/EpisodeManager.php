<?php


namespace App\Manager;


use App\AutoMapping;
use App\Repository\EpisodeRepository;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use Doctrine\ORM\EntityManagerInterface;

class EpisodeManager
{
    private $entityManager;
    private $episodeRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManager, AutoMapping $autoMapping,
 EpisodeRepository $episodeRepository)
    {
        $this->entityManager = $entityManager;
        $this->episodeRepository = $episodeRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateArticleRequest $request)
    {
        $articleEntity = $this->autoMapping->map(CreateArticleRequest::class, Articles::class, $request);
        $articleEntity->setDate();
        $this->entityManager->persist($articleEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $articleEntity;
    }

    public function update(UpdateArticleRequest $request)
    {
        $articleEntity = $this->articleRepository->getArticleById($request->getId());
        if(!$articleEntity)
        {

        }
        else
        {
            $articleEntity = $this->autoMapping->mapToObject(UpdateArticleRequest::class,
             Articles::class, $request, $articleEntity);
            $this->entityManager->flush();
            return $articleEntity;
        }
    }

    public function getAll()
    {
        $data = $this->articleRepository->getAll();

        return $data;
    }

    public function getArticleById(GetByIdRequest $request)
    {
        return $result = $this->articleRepository->getArticleById($request->getId());
    }

    public function delete(DeleteRequest $request)
    {
        $article = $this->articleRepository->getArticleById($request->getId());
        if(!$article)
        {
            return null;
            // return new Response(['data'=>'The project was not found!']);
        }
        else
        {
            $this->entityManager->remove($article);
            $this->entityManager->flush();
        }
        return $article;
    }
}