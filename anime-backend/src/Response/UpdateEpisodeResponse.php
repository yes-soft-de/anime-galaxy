<?php


namespace App\Response;


class UpdateEpisodeResponse
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
     * @param mixed $createdAt
     */
    public function setCreatedAt($createdAt): void
    {
        $this->createdAt = $createdAt;
    }

}