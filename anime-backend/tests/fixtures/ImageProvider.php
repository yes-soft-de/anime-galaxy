<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;


class ImageProvider extends TestCase
{
    //'title' => [ [Expected..],[Actual..] ] ];

    public function create(): array
    {
        return [
           //'title' => [ [rateValue,animeID,userID,creationDate],[Actual,Actual..] ] ];
            'CreateImage' => [ [1,1],[1,1] ] ];    
    }

    public function update(): array
    {
        //'title' => [ [image,animeID],[Actual,Actual..] ] ];
        return [
            'UpdateImage' => [ [1,1],[1,1]]];    
    }

    public function getImagesByAnimeId(): array
    {
        return [
            'getImagesByAnimeId' => [ [2],[2]],   
            'getImagesByAnimeIb2' => [ [02],[02]]
        ];    
    }

    public function delete(): array
    {
        return [
            'deleteImage' => [2,2]
        ];    
    }

}