<?php


namespace App\Response;


class GetAnimeResponse
{
    private $Name;
    private $MainImage;
    private $categoryID;
    private $countInteraction;
    private $rating;

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->Name;
    }

    /**
     * @param mixed $Name
     */
    public function setName($Name): void
    {
        $this->Name = $Name;
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
     * @return mixed
     */
    public function getCountInteraction()
    {
        return $this->countInteraction;
    }

    /**
     * @param mixed $countInteraction
     */
    public function setCountInteraction($countInteraction): void
    {
        $this->countInteraction = $countInteraction;
    }

    /**
     * @return mixed
     */
    public function getRating()
    {
        return $this->rating;
    }

    /**
     * @param mixed $rating
     */
    public function setRating($rating): void
    {
        $this->rating = $rating;
    }


}