<?php

namespace App\Response;

class CreateRatingResponse 
{
    public $id;
    public $userId;
    public $animeId;
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
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * @param mixed $userId
     */
    public function setUserId($userId)
    {
        $this->userId = $userId;

        return $this;
    }

    /**
     * @return mixed
     */  
    public function getAnimeId()
    {
        return $this->animeId;
    }

    /**
     * @param mixed $animeId
     */
    public function setAnimeId($animeId)
    {
        $this->animeId = $animeId;

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