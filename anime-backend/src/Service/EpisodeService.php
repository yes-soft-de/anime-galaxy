<?php


namespace App\Service;


use App\AutoMapping;

class EpisodeService
{
    private $articleManager;
    private $autoMapping;

    public function __construct(ArticleManager $articleManager, AutoMapping $autoMapping)
    {
        $this->articleManager = $articleManager;
        $this->autoMapping = $autoMapping;
    }

    public function create($request)
    {
        $articleResult = $this->articleManager->create($request);
        $response = $this->autoMapping->map(Articles::class, CreateArticleResponse::class, $articleResult);
        return $response;
    }

    public function update($request)
    {
        $articleResult = $this->articleManager->update($request);
        $response = $this->autoMapping->map(Articles::class, UpdateArticleResponse::class, $articleResult);
        $response->setArticle($request->getArticle());
        return $response;
    }

    public function getAll()
    {
        $result = $this->articleManager->getAll();
        $response = [];
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(Articles::class, GetArticleResponse::class, $row);
        }
        return $response;
    }

    public function getArticleById($request)
    {
        $result = $this->articleManager->getArticleById($request);
        $response = $this->autoMapping->map(Articles::class, GetArticleByIdResponse::class, $result);
        return $response;
    }

    public function delete($request)
    {
        $articleResult = $this->articleManager->delete($request);
        if($articleResult==null)
        {
            return null;
        }
        $response = $this->autoMapping->map(Articles::class, GetArticleByIdResponse::class, $articleResult);
        return $response;
    }
}