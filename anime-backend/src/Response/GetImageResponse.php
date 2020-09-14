<?php


namespace App\Response;


class GetImageResponse
{
    private $image;
    private $animeID;

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


}