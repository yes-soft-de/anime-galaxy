<?php


namespace App\Request;


use DateTime;

class CreateAnimeRequest
{
    private $name;
    private $mainImage;
    private $categoryID;
    private $creationDate;
    private $description;
    public  $publishDate;
    public $episodesCount;
    public $trailerVideo;
    private $generalRating;
    private $ageGroup;
    private $posterImage;
    private $posterSpecialLink;

    public function __construct()
    {
        $this->creationDate = new DateTime('Now');
    }
    /**
     * @return mixed
     */
    public function getCreationDate(): DateTime
    {
        return $this->creationDate;
    }

    /**
     * @param mixed $creationDate
     */
    public function setCreationDate(DateTime $creationDate): void
    {
         $this->creationDate = $creationDate;
    }

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     */
    public function setName($name): void
    {
        $this->name = $name;
    }

    /**
     * @return mixed
     */
    public function getMainImage()
    {
        return $this->mainImage;
    }

    /**
     * @param mixed $mainImage
     */
    public function setMainImage($mainImage): void
    {
        $this->mainImage = $mainImage;
    }

    /**
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @param mixed $description
     */
    public function setDescription($description): void
    {
        $this->description = $description;
    }
}