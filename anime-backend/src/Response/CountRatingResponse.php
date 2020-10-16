<?php

namespace App\Response;

class CountRatingResponse
{

    public $avgRating;
   
    /**
     * Set the value of avgRating
     *
     * @return  self
     */ 
    public function setAvgRating($avgRating)
    {
        $this->avgRating = $avgRating;

        return $this;
    }
}
