<?php
namespace App\Tests;

use App\AutoMapping;
use App\Entity\Rating;
use App\Manager\RatingManager;
use App\Request\CreateRatingRequest;
use App\Request\UpdateGradeRequest;
use App\Request\UpdateRatingRequest;
use App\Response\CountRatingResponse;
use App\Response\CreateRatingResponse;
use App\Response\UpdateRatingResponse;
use App\Service\GradeService;
use App\Service\RatingService;
use App\Tests\fixtures\RatingProvider;
use PHPUnit\Framework\TestCase;

class RatingServiceUnitTest extends TestCase
{

    private $mockRatingManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    protected function setUp()
    {
        $this->mockRatingManager = $this->createMock(RatingManager::class);
        $this->gradeService = $this->createMock(GradeService::class);
        $this->updateGradeRequest = $this->createMock(updateGradeRequest::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreateWithDataProvider($expected,$actual)
    {
        $createRatingResponse = new CreateRatingResponse();
        $createRatingResponse->rateValue = $expected;
        $createRatingResponse->animeID = $expected;
        $createRatingResponse->userID = $expected;
        // $createRatingResponse->creationDate = $expected;

        $rating = new Rating();
        $rating->setRateValue($actual);
        $rating->setAnimeID($actual);
        $rating->setUserID($actual);
        // $rating->setCreationDate($actual);

        $createRatingRequest = new CreateRatingRequest();

        $this->mockRatingManager
            ->method('create')
            ->willReturn($rating);

        $ratingService = new RatingService($this->mockRatingManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);
        $this->assertEquals($createRatingResponse, $ratingService->create($createRatingRequest));

    }

    public function create()
    {
        $result = new RatingProvider();
        return $result->create();
    }

    /**
     * @dataProvider update
     */
    public function testUpdateWithDataProvider($expected, $actual)
    {
        $updateRatingResponse = new UpdateRatingResponse();
        $updateRatingResponse->rateValue = $expected;
        $updateRatingResponse->animeID = $expected;
        $updateRatingResponse->userID = $expected;

        $rating = new Rating();
        $rating->setRateValue($actual);
        $rating->setAnimeID($actual);
        $rating->setUserID($actual);

        $UpdateRatingRequest = new UpdateRatingRequest();

        $this->mockRatingManager
            ->method('update')
            ->willReturn($rating);

        $ratingService = new RatingService($this->mockRatingManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);

        $this->assertEquals($updateRatingResponse, $ratingService->update($UpdateRatingRequest));
    }

    public function update()
    {
        $result = new RatingProvider();
        return $result->update();
    }

     /**
     * @dataProvider getAllRatings
     */
    public function testGetAllRatingsByAnimeIdWithDataProvider( $expected,  $actual)
    {       
        $Response = new CountRatingResponse();
        $Response->setAvgRating($expected);
        
        $this->mockRatingManager
            ->method('getAllRatings')
            ->willReturn(["avgRating" => $actual]);

        $ratingService = new RatingService($this->mockRatingManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);
        
        $this->assertEquals($Response, $ratingService->getAllRatings($actual));
        
    }

    public function getAllRatings()
    {
        $result = new RatingProvider();
        return $result->getAllRatingsByAnimeID();
    }

}