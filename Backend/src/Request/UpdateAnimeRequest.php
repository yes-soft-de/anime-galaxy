<?php


namespace App\Request;


class UpdateAnimeRequest
{
    private $id;
    private $name;
    private $mainImage;
    private $categoryID;
    private $description;
    private $episodesCount;
    private $trailerVideo;
    private $generalRating;
    private $ageGroup;
    private $posterImage;
    private $posterSpecialLink;

    /**
     * @return mixed
     */
    public function getTrailerVideo()
    {
        return $this->trailerVideo;
    }

    /**
     * @param mixed $trailerVideo
     */
    public function setTrailerVideo($trailerVideo): void
    {
        $this->trailerVideo = $trailerVideo;
    }

    /**
     * @return mixed
     */
    public function getEpisodesCount()
    {
        return $this->episodesCount;
    }

    /**
     * @param mixed $episodesCount
     */
    public function setEpisodesCount($episodesCount): void
    {
        $this->episodesCount = $episodesCount;
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
    public function getCategoryID()
    {
        return $this->categoryID;
    }

    /**
     * @param mixed $categoryID
     */
    public function setCategoryID($categoryID): void
    {
        $this->categoryID = $categoryID;
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