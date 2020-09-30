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

    private $createdAt;

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
     * @return mixed
     */
    public function getCreatedAt()
    {
        return $this->createdAt;
    }


}