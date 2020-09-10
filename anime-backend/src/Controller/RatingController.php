<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\AutoMapping;
use App\Service\RatingService;
use App\Request\CreateRatingRequest;
use App\Request\UpdateRatingRequest;
use App\Request\GetByIdRequest;
use Symfony\Component\HttpFoundation\Response;

class RatingController extends BaseController
{
    private $ratingService;
    private $autoMapping;


    /**
     * RatingController constructor.
     * @param RatingService $interActionService
     */
    public function __construct(RatingService $ratingService,AutoMapping $autoMapping)
    {
        $this->ratingService  = $ratingService;
        $this->autoMapping    = $autoMapping;
    } 


    
    /**
     * @Route("/rating/{userID}/{animeID}/{rateValue}", name="createRating", name="createRating",methods={"POST"})
     */
    public function create(Request $request, $userID , $animeID, $rateValue)
    {
         $data = json_decode($request->getContent(), true);
         $request=$this->autoMapping->map(\stdClass::class,CreateRatingRequest::class,(object)$data);
         $request->setUserId($userID);
         $request->setAnimeId($animeID);
         $request->setRateValue($rateValue);
         $result = $this->ratingService->create($request, $userID , $animeID, $rateValue);
         return $this->response($result, self::CREATE);
    }
    
    

    /**
     * @Route("/rating/{animeID}/{userID}", name="getRatingByAnimeIDAndUserID",methods={"GET"})
     * @return JsonResponse
     */
    public function getRating($animeID, $userID)
    {
        $result = $this->ratingService->getRating($animeID, $userID);
       
        return $this->response($result, self::FETCH);
    }


    
    /**
     * @Route("/ratings/{animeID}", name="getAllRatingsByAnimeID",methods={"GET"})
     * @return JsonResponse
     */
    public function getAllRatings($animeID)
    {
        
        $result = $this->ratingService->getAllRatings($animeID);
       
        return $this->response($result, self::FETCH);
    }
}
