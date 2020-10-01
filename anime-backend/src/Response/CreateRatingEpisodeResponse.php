<?php

namespace App\Response;

class CreateRatingEpisodeResponse 
{
    public $id;
    public $userID;
    public $episodeID;
    public $rateValue;
    public $creationDate;
     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
    }
    

   /**
     * @return mixed
     */ 
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userId
     */
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }

    /**
     * @return mixed
     */  
    public function getEpisodeID()
    {
        return $this->episodeID;
    }

    /**
     * @param mixed $episodeID
     */
    public function setEpisodeID($episodeID)
    {
        $this->episodeID = $episodeID;

        return $this;
    }
 /**
     * @return mixed
     */ 
    public function getRateValue()
    {
        return $this->rateValue;
    }

   /**
     * @param mixed $rateValue
     */
    public function setRateValue($rateValue)
    {
        $this->rateValue = $rateValue;

        return $this;
    }
}