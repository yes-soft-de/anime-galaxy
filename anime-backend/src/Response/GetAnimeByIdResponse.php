<?php


namespace App\Response;


class GetAnimeByIdResponse
{
    private $Name;
    private $MainImage;
    private $categoryID;

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
}