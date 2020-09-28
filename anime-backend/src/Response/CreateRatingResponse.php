<?php

namespace App\Response;

class CreateRatingResponse 
{
    public $id;
    public $userID;
    public $animeID;
    public $rateValue;

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
    public function getAnimeID()
    {
        return $this->animeID;
    }

    /**
     * @param mixed $animeID
     */
    public function setAnimeIDs($animeID)
    {
        $this->animeID = $animeID;

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