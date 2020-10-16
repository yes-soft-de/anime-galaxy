<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class RatingProvider extends TestCase
{

    public function create()
    { 
        return [
            //'title' => [Expected..],[Actual..] 
            'CreateRate' => [1, 1], [1, 1],[12, 12], [13, 13]
        ];
    }

    public function update()
    {
        return [
            'UpdateRate' => [1, 1], [1, 1],[11, 11], [11, 11]
                ];
    }

    public function getAllRatingsByAnimeID()
    {
        return [
            'getAllRatingsByAnimeID' => [112, 112], [1020, 1020],[120, 120]
                ];
    }

}
