<?php

namespace App\Response;

class GetFavouriteResponse
{
    public $id;
    public $animeID;
    public $mainImage;
    public $AnimeName;
    public $categories = [];
//    public $categoryName = [];
    public $date;

     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
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
}