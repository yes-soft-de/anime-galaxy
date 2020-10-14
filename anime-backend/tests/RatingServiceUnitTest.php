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
    public function testCreateWithDataProvider(array $expected, array $actual)
    {
        $createRatingResponse = new CreateRatingResponse();
        $createRatingResponse->rateValue = $expected[0];
        $createRatingResponse->animeID = $expected[1];
        $createRatingResponse->userID = $expected[2];
        $createRatingResponse->creationDate = $expected[3];

        $rating = new Rating();
        $rating->setRateValue($actual[0]);
        $rating->setAnimeID($actual[1]);
        $rating->setUserID($actual[2]);
        $rating->setCreationDate($actual[3]);

        $createRatingRequest = new CreateRatingRequest($actual[3]);

        $this->mockRatingManager
            ->method('create')
            ->willReturn($rating);

        $ratingService = new RatingService($this->mockRatingManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);
        $this->assertEquals($createRatingResponse, $ratingService->create($createRatingRequest));

    }

    /**
     * return string[][]
     */
    public function create()
    {
        $result = new RatingProvider();
        return $result->create();
    }

    /**
     * @dataProvider update
     */
    public function testUpdateWithDataProvider(array $expected, array $actual)
    {
        $updateRatingResponse = new UpdateRatingResponse();
        $updateRatingResponse->rateValue = $expected[0];
        $updateRatingResponse->animeID = $expected[1];
        $updateRatingResponse->userID = $expected[2];

        $rating = new Rating();
        $rating->setRateValue($actual[0]);
        $rating->setAnimeID($actual[1]);
        $rating->setUserID($actual[2]);

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

    public function testGetAllRatingsByAnimeIdWithDataProvider()
    {
        $Response = new CountRatingResponse();
        $Response->setAvgRating(1);
        
        $this->mockRatingManager
            ->method('getAllRatings')
            ->willReturn(["avgRating" => "1"]);

        $ratingService = new RatingService($this->mockRatingManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);
        
        $this->assertEquals($Response, $ratingService->getAllRatings("1"));

    }

    public function getAllRatings()
    {
        $result = new RatingProvider();
        return $result->getAllRatingsByAnimeId();
    }

}
