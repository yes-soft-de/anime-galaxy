<?php


namespace App\Request;


class UpdateEpisodeRequest
{
    private $id;
    private $animeID;
    private $seasonNumber;
    private $episodeNumber;
    private $description;
    private $image;
    private $duration;
    private $publishDate;
    private $categories;
    private $posterImage;
    private $posterSpecialLink;
    private $updatedBy;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getAnimeID()
    {
        return $this->animeID;
    }

    /**
     * @return mixed
     */
    public function getSeasonNumber()
    {
        return $this->seasonNumber;
    }

    /**
     * @return mixed
     */
    public function getEpisodeNumber()
    {
        return $this->episodeNumber;
    }

    /**
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * @return mixed
     */
    public function getDuration()
    {
        return $this->duration;
    }

    /**
     * @return mixed
     */
    public function getPublishDate()
    {
        return $this->publishDate;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }

    /**
     * @param mixed $animeID
     */
    public function setAnimeID($animeID): void
    {
        $this->animeID = $animeID;
    }

    /**
     * @param mixed $seasonNumber
     */
    public function setSeasonNumber($seasonNumber): void
    {
        $this->seasonNumber = $seasonNumber;
    }

    /**
     * @param mixed $episodeNumber
     */
    public function setEpisodeNumber($episodeNumber): void
    {
        $this->episodeNumber = $episodeNumber;
    }

    /**
     * @param mixed $description
     */
    public function setDescription($description): void
    {
        $this->description = $description;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
    }

    /**
     * @param mixed $duration
     */
    public function setDuration($duration): void
    {
        $this->duration = $duration;
    }

    /**
     * @param mixed $publishDate
     */
    public function setPublishDate($publishDate): void
    {
        $this->publishDate = $publishDate;
    }

    /**
     * @param mixed $updatedBy
     */
    public function setUpdatedBy($updatedBy): void
    {
        $this->updatedBy = $updatedBy;
    }

}