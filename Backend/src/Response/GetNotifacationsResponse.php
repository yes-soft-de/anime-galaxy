<?php

namespace App\Response;

class GetNotifacationsResponse
{
    public $id;
    public $animeID;
    public $mainImage;
    public $AnimeName;
    public $categoryID;
    public $categoryName;
    public $episodeID;
    public $publishDate;
   

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