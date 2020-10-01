<?php

namespace App\Response;

class CreateFavouriteResponse
{
    public $id;
    public $userID;
    public $animeID;
    public $categoryID;
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
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
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
    public function setAnimeID($animeID): void
    {
        $this->animeID = $animeID;
    }



    /**
     * Get the value of categoryID
     */ 
    public function getCategoryID()
    {
        return $this->categoryID;
    }

    /**
     * Set the value of categoryID
     *
     * @return  self
     */ 
    public function setCategoryID($categoryID)
    {
        $this->categoryID = $categoryID;

        return $this;
    }
}