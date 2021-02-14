<?php


namespace App\Response;


class GetCategoryByIdResponse
{
    public $id;
    public $name;
    public $description;
    public $image;
    public $coverImage;
    public $coverImageURL;
    public $imageURL;
    public $baseURL;
    public $titleShow;

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
     * @param mixed $imageURL
     */
    public function setImageURL($imageURL): void
    {
        $this->imageURL = $imageURL;
    }

    /**
     * @return mixed
     */
    public function getImageURL()
    {
        return $this->imageURL;
    }

    /**
     * @param mixed $baseURL
     */
    public function setBaseURL($baseURL): void
    {
        $this->baseURL = $baseURL;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
    }

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    public function setCoverImage($coverImage)
    {
        $this->coverImage = $coverImage;
    }

    public function getCoverImage()
    {
        return $this->coverImage;
    }
    
    /**
     * @return mixed
     */
    public function setCoverImageURL($coverImageURL)
    {
        return $this->coverImageURL = $coverImageURL;
    }

}