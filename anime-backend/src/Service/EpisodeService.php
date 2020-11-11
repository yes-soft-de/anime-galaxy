<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Episode;
use App\Manager\EpisodeManager;
use App\Request\CreateEpisodeRequest;
use App\Response\CreateEpisodeResponse;
use App\Response\GetEpisodeByIdResponse;
use App\Response\GetEpisodeResponse;
use App\Response\UpdateEpisodeResponse;
use App\Response\GetEpisodeCommingSoonResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class EpisodeService
{
    private $episodeManager;
    private $autoMapping;
    private $commentService;
    private $interactionService;
    private $params;

    public function __construct(EpisodeManager $episodeManager, AutoMapping $autoMapping, CommentEpisodeService $commentService,
                                InteractionEpisodeService $interactionService, ParameterBagInterface $params)
    {
        $this->episodeManager = $episodeManager;
        $this->autoMapping = $autoMapping;
        $this->commentService = $commentService;
        $this->interactionService = $interactionService;

        $this->params = $params->get('upload_base_url').'/';
    }

    public function create(CreateEpisodeRequest $request)
    {
        $episodeResult = $this->episodeManager->create($request);
        return $this->autoMapping->map(Episode::class, CreateEpisodeResponse::class, $episodeResult);
    }

    public function update($request)
    {
        $episodeResult = $this->episodeManager->update($request);
        $response = $this->autoMapping->map(Episode::class, UpdateEpisodeResponse::class, $episodeResult);

        $response->setDescription($request->getDescription());
        $response->setImage($request->getImage());

        return $response;
    }

    public function getEpisodesByAnimeId($animeID)
    {
        $response = [];
        $result = $this->episodeManager->getEpisodesByAnimeId($animeID);

        foreach ($result as $row)
        {
            $row['image'] = $this->specialLinkCheck($row['specialLink']).$row['image'];

            $row['episodInteraction']=[
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id'])
                ];
            
            $response[] = $this->autoMapping->map('array', GetEpisodeResponse::class, $row); 
        }

        return $response;
    }

    public function getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber)
    {
        $response = [];
        $result = $this->episodeManager->getEpisodesByAnimeIdAndSeasonNumber($animeID, $seasonNumber);

        foreach ($result as $row)
        {
            $row['image'] = $this->specialLinkCheck($row['specialLink']).$row['image'];

            $row['interaction'] = [
                'love' => $this->interactionService->lovedAll($row['id']),
                'like' => $this->interactionService->likeAll($row['id']),
                'dislike' => $this->interactionService->dislikeAll($row['id'])
                ];
            $response[] = $this->autoMapping->map('array', GetEpisodeResponse::class, $row);
        }

        return $response;
    }

    public function getEpisodeById($request)
    {
        $response= [];
        $result = $this->episodeManager->getEpisodeById($request);
        $resultComments = $this->commentService->getCommentsByEpisodeId($request);
        $love = $this->interactionService->loved($request);
        $like = $this->interactionService->like($request);
        $dislike = $this->interactionService->dislike($request);
        
        foreach ($result as $row)
        {
            $row['image'] = $this->specialLinkCheck($row['specialLink']).$row['image'];

            $response = $this->autoMapping->map('array', GetEpisodeByIdResponse::class, $row);
        }
        if($result){
        $response->setComments($resultComments);
        $response->interactions['love'] = $love;
        $response->interactions['like'] = $like;
        $response->interactions['dislike'] = $dislike;
        }
        return $response;
    }

    public function delete($request)
    {
        $episodeResult = $this->episodeManager->delete($request);

        if($episodeResult == null)
        {
            return null;
        }

        return $this->autoMapping->map(Episode::class, GetEpisodeByIdResponse::class, $episodeResult);
    }

    public function getAllComingSoon()
    {
        /** @var $response */
       
        $result = $this->episodeManager->getAllComingSoon();
        $response = [];
        
        foreach ($result as $row)
        {
            $row['image'] = $this->specialLinkCheck($row['specialLink']).$row['image'];

            $response[] = $this->autoMapping->map('array', GetEpisodeCommingSoonResponse::class, $row); 
        }

        return $response;
    }

    public function specialLinkCheck($bool)
    {
        if (!$bool)
        {
            return $this->params;
        }
    }
}