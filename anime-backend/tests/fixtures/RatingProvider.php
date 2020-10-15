<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;


class RatingProvider extends TestCase
{
    
    public function create(): array
    {
        return [
           //'title' => [ [Expected..],[Actual..] ] ];
           //'title' => [ [rateValue,animeID,userID,creationDate],[Actual,Actual..] ] ];
            'CreateRate' => [ [1,1,'1'],[1,1,'1'] ] ];    
    }

    
    public function update(): array
    {
        return [
            'UpdateRate' => [ [1,1,'1'],[1,1,'1'] ] ];    
    }

}