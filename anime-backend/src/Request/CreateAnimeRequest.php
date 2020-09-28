<?php


namespace App\Request;


class CreateAnimeRequest
{
    private $id;
    private $name;
    private $mainImage;
    private $categoryID;
    private $creationDate;


    /**
     * @return mixed
     */
    public function getCreationDate(): ?\DateTimeInterface
    {
        return $this->creationDate;
    }

    /**
     * @param mixed $creationDate
     */
    public function setCreationDate(?\DateTimeInterface $creationDate): void
    {
        // $this->creationDate = $creationDate;
        $this->creationDate = new \DateTime('Now');
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

}