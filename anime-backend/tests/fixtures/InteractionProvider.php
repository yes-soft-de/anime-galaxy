<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;

class InteractionProvider extends TestCase
{

    public function create()
    { 
        return [
            //'title' => [Expected..],[Actual..] 
            'CreateInteraction' => [1, 1]
        ];
    }

    public function update()
    {
        return [
            'UpdateInteraction' => [1, 1], [1, 1],[11, 11], [11, 11]
                ];
    }

    public function getAllInteractionsByAnimeID()
    {
        return [
            'getAllInteractionsByAnimeID' => [112, 112]
                ];
    }

    public function getInteractionWithUser()
    {
        return [
            'getInteractionWithUser' => [112, 112]
                ];
    }

    public function loved()
    {
        return [
            'loved' => [112]
                ];
    }

}
