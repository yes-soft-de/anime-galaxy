<?php


namespace App\Response;


class GetcommentsNumberResponse
{
    public $commentsNumber;


    /**
     * Set the value of commentsNumber
     *
     * @return  self
     */ 
    public function setCommentsNumber($commentsNumber)
    {
        $this->commentsNumber = $commentsNumber;

        return $this;
    }

    /**
     * Get the value of commentsNumber
     */ 
    public function getCommentsNumber()
    {
        return $this->commentsNumber;
    }
}