<?php

namespace App\Response;

class GetWatchListByIdResponse
{
    public $id;
    public $userID;
    public $animeID;

     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
    }
    

   

    /**
     * Set the value of userID
     *
     * @return  self
     */ 
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }

    /**
     * Set the value of animeID
     *
     * @return  self
     */ 
    public function setAnimeID($animeID)
    {
        $this->animeID = $animeID;

        return $this;
    }
}