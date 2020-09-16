<?php

namespace App\Request;

class CreateRatingRequest
{
    private $id;
    private $userID;
    public  $animeID;
    private $rateValue;

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
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserId($userID)
    {
        $this->userID = $userID;

        return $this;
    }

    /**
     * @return mixed
     */  
    public function getAnimeId()
    {
        return $this->animeID;
    }

    /**
     * @param mixed $animeID
     */
    public function setAnimeId($animeID)
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