<?php

namespace App\Response;

class CreateFavouriteResponse
{
    public $id;
    public $userID;
    public $animeID;
    public $categories = [];
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
     * Get the value of categories
     */ 
    public function getCategories(): array
    {
        return $this->categories;
    }

    /**
     * Set the value of categories
     *
     * @return  self
     */ 
    public function setCategories($categories)
    {
        $this->categories = $categories;

        return $this;
    }
}