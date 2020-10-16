<?php

namespace App\Tests;

use App\AutoMapping;
use App\Entity\Image;
use App\Manager\ImageManager;
use App\Request\CreateImageRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Request\UpdateImageRequest;
use App\Response\CreateImageResponse;
use App\Response\GetImageByIdResponse;
use App\Response\GetImageResponse;
use App\Response\UpdateImageResponse;
use App\Service\ImageService;
use App\Tests\fixtures\ImageProvider;
use PHPUnit\Framework\TestCase;

class ImageServiceUnitTest extends TestCase
{

    private $mockManager;
    private $autoMapping;

    protected function setUp()
    {
        $this->mockImageManager = $this->createMock(ImageManager::class);
        $this->autoMapping = new AutoMapping();
    }

    /**
     * @dataProvider create
     */
    public function testCreateWithDataProvider($expected, $actual)
    {
        $createImageResponse = new CreateImageResponse();
        $createImageResponse->animeID = $expected;
        $createImageResponse->image = $expected;

        $image = new Image();
        $image->setAnimeID($actual);
        $image->setImage($actual);

        $createImageRequest = new CreateImageRequest();

        $this->mockImageManager
            ->method('create')
            ->willReturn($image);

        $imageService = new ImageService($this->mockImageManager, $this->autoMapping);

        $this->assertEquals($createImageResponse, $imageService->create($createImageRequest));

    }

    public function create()
    {
        $result = new ImageProvider();
        return $result->create();
    }

    /**
     * @dataProvider update
     */
    public function testUpdateWithDataProvider($expected, $actual)
    {
        $Response = new UpdateImageResponse();
        $Response->image = $expected;
        $Response->animeID = $expected;

        $image = new Image();
        $image->setImage($actual);
        $image->setAnimeID($actual);

        $UpdateImageRequest = new UpdateImageRequest();

        $this->mockImageManager
            ->method('update')
            ->willReturn($image);

        $imageService = new ImageService($this->mockImageManager, $this->autoMapping);

        $this->assertEquals($Response, $imageService->update($UpdateImageRequest));
    }

    public function update()
    {
        $result = new ImageProvider();
        return $result->update();
    }

    //  Get All
    public function testGetAllWithDataProvider()
    {
        $image = new Image();
        $this->mockImageManager
            ->method('getAll')
            ->willReturn($image);

        $imageService = new ImageService($this->mockImageManager, $this->autoMapping);
        $this->assertIsArray($imageService->getAll());
    }

    /**
     * @dataProvider GetImagesByAnimeId
     */
    public function testGetImagesByAnimeIdWithDataProvider($expected, $actual)
    {
        $Response = new GetImageResponse();
        $Response->setImage($expected);

        $image = new Image();
        $image->setImage($actual);

        $getByIdRequest = new GetByIdRequest($actual);
        
        $this->mockImageManager
            ->method('getImagesByAnimeID')
            ->willReturn($image);

        $imageService = new ImageService($this->mockImageManager, $this->autoMapping);
        $this->assertIsArray($imageService->getImagesByAnimeId($getByIdRequest));
        
    }

    public function getImagesByAnimeId()
    {
        $result = new ImageProvider();
        return $result->getImagesByAnimeId();
    }

    /**
     * @dataProvider delete
     */
    public function testdeleteWithDataProvider($expected, $actual)
    {
        $Response = new GetImageByIdResponse();
        $Response->image = $expected;
        $Response->animeID = $expected;

        $image = new Image();
        $image->setId($actual);
        $image->setImage($actual);
        $image->setAnimeID($actual);

        $deleteImageRequest = new DeleteRequest($image->getId());

        $this->mockImageManager
            ->method('delete')
            ->willReturn($image);

        $imageService = new ImageService($this->mockImageManager, $this->autoMapping);

        $this->assertEquals($Response, $imageService->delete($deleteImageRequest));
    }

    public function delete()
    {
        $result = new ImageProvider();
        return $result->delete();
    }
}
