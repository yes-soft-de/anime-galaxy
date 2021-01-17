<?php


namespace App\Response;


class CreateAnimeResponse
{
    public $name;
    public $mainImage;
    public $categories;
//    public $creationDate;
    public $description;
    public $publishDate;
    public $episodesCount;
    public $trailerVideo;
    public $generalRating;
    public $ageGroup;
    public $posterImage;

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param $name
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
     * @param $mainImage
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

//    /**
//     * @return mixed
//     */
//    public function getCreationDate()
//    {
//        return $this->creationDate;
//    }
//
//    /**
//     * @param mixed $creationDate
//     */
//    public function setCreationDate($creationDate): void
//    {
//        $this->creationDate = $creationDate;
//    }

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