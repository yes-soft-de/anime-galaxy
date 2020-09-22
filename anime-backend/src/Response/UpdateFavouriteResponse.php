<?php

namespace App\Response;

class UpdateFavouriteResponse
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
     * @return mixed
     */ 
    public function getUserId()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @param mixed $animeID
     */
    public function setAnimeID($animeID): void
    {
        $this->animeID = $animeID;
    }

    /**
     * @return mixed
     */  
    public function getAnimeId()
    {
        return $this->animeID;
    }
}