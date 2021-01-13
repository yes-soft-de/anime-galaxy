<?php


namespace App\Request;


use DateTime;

class CreateEpisodeRequest
{
    private $animeID;
    private $seasonNumber;
    private $episodeNumber;
    private $description;
    private $image;
    private $duration;
    private $publishDate;
    //private $createdAt;
    private $categories;
    private $posterImage;
    private $posterSpecialLink;
    private $createdBy;

    /**
     * CreateArticleRequest constructor.
     */
    public function __construct()
    {
        //$this->createdAt = new DateTime('Now');
    }

//    /**
//     * @param DateTime $createdAt
//     */
//    public function setCreatedAt(DateTime $createdAt): void
//    {
//        $this->createdAt = $createdAt;
//    }

    /**
     * @return mixed
     */
    public function getDuration()
    {
        return $this->duration;
    }

    /**
     * @param mixed $createdBy
     */
    public function setCreatedBy($createdBy): void
    {
        $this->createdBy = $createdBy;
    }


}