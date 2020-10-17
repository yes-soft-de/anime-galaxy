<?php

namespace App\Request;

class CreateImageRequest
{
    private $image;
    private $animeID;
    private $specialLink;
    
    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
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
     * @return mixed
     */
    public function getSpecialLink()
    {
        return $this->specialLink;
    }

    /**
     * @param mixed $specialLink
     */
    public function setSpecialLink($specialLink)
    {
        $this->specialLink = $specialLink;
    }


}
