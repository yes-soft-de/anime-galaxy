<?php

namespace App\Tests;

use App\AutoMapping;

use App\Entity\Interaction;
use App\Manager\InteractionManager;
use App\Response\CreateInteractionResponse;
use App\Response\UpdateInteractionResponse;
use App\Response\GetInteractionResponse;
use App\Request\CreateInteractionRequest;
use App\Request\UpdateInteractionRequest;
use App\Service\InteractionService;
use App\Service\GradeService;
use App\Request\UpdateGradeRequest;
use App\Request\GetByIdRequest;
use App\Tests\fixtures\InteractionProvider;
use PHPUnit\Framework\TestCase;

class InteractionServiceUnitTest extends TestCase
{
    private $mockManager;
    private $autoMapping;
    private $gradeService;
    private $updateGradeRequest;

    protected function setUp()
    {
        $this->mockManager = $this->createMock(InteractionManager::class);
        $this->gradeService = $this->createMock(GradeService::class);
        $this->updateGradeRequest = $this->createMock(updateGradeRequest::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreateWithDataProvider($expected,$actual)
    {
        $createResponse = new CreateInteractionResponse();
        $createResponse->type = $expected;
        $createResponse->animeID = $expected;
        $createResponse->userID = $expected;

        $entity = new Interaction();
        $entity->setType($actual);
        $entity->setAnimeID($actual);
        $entity->setUserID($actual);

        $createRequest = new CreateInteractionRequest();

        $this->mockManager
            ->method('create')
            ->willReturn($entity);

        $Service = new InteractionService($this->mockManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);
        $this->assertEquals($createResponse, $Service->create($createRequest));

    }

    public function create()
    {
        $result = new InteractionProvider();
        return $result->create();
    }

    /**
     * @dataProvider update
     */
    public function testUpdateWithDataProvider($expected, $actual)
    {
        $updateResponse = new UpdateInteractionResponse();
        $updateResponse->type = $expected;
        $updateResponse->animeID = $expected;
        $updateResponse->userID = $expected;

        $entity = new Interaction();
        $entity->setType($actual);
        $entity->setAnimeID($actual);
        $entity->setUserID($actual);

        $UpdateRequest = new UpdateInteractionRequest();

        $this->mockManager
            ->method('update')
            ->willReturn($entity);

        $Service = new InteractionService($this->mockManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);

        $this->assertEquals($updateResponse, $Service->update($UpdateRequest));
    }

    public function update()
    {
        $result = new InteractionProvider();
        return $result->update();
    }

    /**
     * @dataProvider getAllInteractions
     */
    public function testGetAllInteractionsByAnimeIdWithDataProvider( $expected,  $actual)
    {       
        $Response = new GetInteractionResponse();
        $Response->setType($expected);
        $Response->setAnimeID($expected);
        $Response->setUserID($expected);
        
        $entity = new Interaction();
        $entity->setType($actual);
        $entity->setAnimeID($actual);
        $entity->setUserID($actual);

        $this->mockManager
            ->method('getAll')
            ->willReturn($entity);

        $Service = new InteractionService($this->mockManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);

        $this->assertIsArray($Service->getAll($actual));
        
    }

    public function getAllInteractions()
    {
        $result = new InteractionProvider();
        return $result->getAllInteractionsByAnimeID();
    }
    
    /**
     * @dataProvider getInteractionWithUser
     */
    public function testGetAllInteractionsWithUserWithDataProvider( $expected,  $actual)
    {       
        $Response = new GetInteractionResponse();
        $Response->setType($expected);
        $Response->setAnimeID($expected);
        $Response->setUserID($expected);
        
        $entity = new Interaction();
        $entity->setType($actual);
        $entity->setAnimeID($actual);
        $entity->setUserID($actual);

        $this->mockManager
            ->method('getInteractionWithUser')
            ->willReturn($entity);

        $Service = new InteractionService($this->mockManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);

        $this->assertIsArray($Service->getInteractionWithUser($actual, $actual));
        
    }

    public function getInteractionWithUser()
    {
        $result = new InteractionProvider();
        return $result->getInteractionWithUser();
    }
    // /**
    //  * @dataProvider loved
    //  */
    // public function testlovedDataProvider( $expected,  $actual)
    // {       
    //     // $Response = new GetInteractionResponse();
    //     // $Response->setType($expected);
    //     // $Response->setAnimeID($expected);
    //     // $Response->setUserID($expected);
        
    //     $entity = new Interaction();
    //     $entity->setType($actual);
    //     $entity->setAnimeID($actual);
    //     $entity->setUserID($actual);

    //     $getByIdRequest = new GetByIdRequest($actual);

    //     $this->mockManager
    //         ->method('loved')
    //         ->willReturn($entity);

    //     $Service = new InteractionService($this->mockManager, $this->autoMapping, $this->gradeService, $this->updateGradeRequest);

    //     $this->assertIsObject($Service->loved( $getByIdRequest));
        
    // }

    // public function loved()
    // {
    //     $result = new InteractionProvider();
    //     return $result->loved();
    // }
}