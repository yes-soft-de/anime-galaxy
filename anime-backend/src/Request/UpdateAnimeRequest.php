<?php


namespace App\Request;


class UpdateAnimeRequest
{
    private $id;
    private $name;
    private $mainImage;
    private $categories;
    private $description;
    private $episodesCount;
    private $trailerVideo;
    private $generalRating;
    private $ageGroup;
    private $posterImage;
    private $posterSpecialLink;
    private $publishDate;
    private $updatedBy;

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
    public function getCategories()
    {
        return $this->categories;
    }

    /**
     * @param mixed $categories
     */
    public function setCategories($categories): void
    {
        $this->categories = $categories;
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

    /**
     * @return mixed
     */
    public function getPublishDate()
    {
        return $this->publishDate;
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