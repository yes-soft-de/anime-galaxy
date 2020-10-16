<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class ImageProvider extends TestCase
{
    //'title' =>[Expected..],[Actual..]

    public function create(): array
    {
        return [

            'CreateImage' => [1, 1], [1, 1],[101, 101], [21, 21]
        ];
    }

    public function update(): array
    {
        return [
            'UpdateImage' => [1, 1], [1, 1],[10, 10], [101, 101]
        ];
    }

    public function getImagesByAnimeId(): array
    {
        return [
            'getImagesByAnimeId' => [2,2],[02,02]
        ];
    }

    public function delete(): array
    {
        return [
            'deleteImage' => [2, 2],[20, 20]
        ];
    }

}
