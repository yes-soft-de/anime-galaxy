<?php


namespace App\Request;


use DateTime;

class CreateEpisodeRequest
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
     * CreateArticleRequest constructor.
     */
    public function __construct()
    {
        $this->createdAt = new DateTime('Now');
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }



}