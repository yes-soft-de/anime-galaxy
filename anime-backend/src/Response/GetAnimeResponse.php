<?php


namespace App\Response;


class GetAnimeResponse
{
    private $name;
    private $MainImage;
    private $categoryID;
    public $countAllInteraction;
    public $rating;
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
        return $this->MainImage;
    }

    /**
     * @param mixed $MainImage
     */
    public function setMainImage($MainImage): void
    {
        $this->MainImage = $MainImage;
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
     * @param mixed $countAllInteraction
     */
    public function setCountAllInteraction($countAllInteraction): void
    {
        $this->countAllInteraction = $countAllInteraction;
    }

    /**
     * @param mixed $rating
     */
    public function setRating($rating): void
    {
        $this->rating = $rating;
    }
}