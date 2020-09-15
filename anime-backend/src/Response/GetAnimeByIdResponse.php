<?php


namespace App\Response;


class GetAnimeByIdResponse
{
    public $name;
    public $mainImage;
    public $categoryName;
    public $countInteraction;
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
    public function getCategoryName()
    {
        return $this->categoryName;
    }

    /**
     * @param mixed $categoryName
     */
    public function setCategoryName($categoryName): void
    {
        $this->categoryName = $categoryName;
    }

    /**
     * Get the value of countInteraction
     */ 
    public function getCountInteraction()
    {
        return $this->countInteraction;
    }

    /**
     * Set the value of countInteraction
     *
     * @return  self
     */ 
    public function setCountInteraction($countInteraction)
    {
        $this->countInteraction = $countInteraction;

        return $this;
    }

    /**
     * Set the value of rating
     *
     * @return  self
     */ 
    public function setRating($rating)
    {
        $this->rating = $rating;

        return $this;
    }
}