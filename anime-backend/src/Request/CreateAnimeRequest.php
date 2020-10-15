<?php


namespace App\Request;


use DateTime;

class CreateAnimeRequest
{
    private $name;
    private $mainImage;
    private $categoryID;
    private $creationDate;
    private $age;
    private $trailer;

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


}