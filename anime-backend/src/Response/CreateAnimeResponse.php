<?php


namespace App\Response;


class CreateAnimeResponse
{
    private $name;
    private $mainImage;
    private $categoryID;

    /**
     * CreateAnimeResponse constructor.
     */
    public function __construct()
    {
    }

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
}