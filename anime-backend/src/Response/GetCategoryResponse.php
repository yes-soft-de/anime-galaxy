<?php


namespace App\Response;


class GetCategoryResponse
{
    public $id;
    public $name;
    public $description;
    public $image;
    public $coverImage;
    public $imageURL;
    public $baseURL;
    public $createdAt;
    public $updatedAt;
    public $updatedBy;
    public $createdBy;
    public $titleShow;

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

}