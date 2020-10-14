<?php

namespace App\Tests\fixtures;

use PHPUnit\Framework\TestCase;


class RatingProvider extends TestCase
{
    
    public function create(): array
    {$date = new \DateTime('2020-02-05 09:05:55');
        return [
           //'title' => [ [Expected..],[Actual..] ] ];
           //'title' => [ [rateValue,animeID,userID,creationDate],[Actual,Actual..] ] ];
            'CreateRate' => [ [1,1,'1',$date],[1,1,'1','2020-02-05 09:05:55'] ] ];    
    }

    
    public function update(): array
    {
        return [
            'UpdateRate' => [ [1,1,'1'],[1,1,'1'] ] ];    
    }

}