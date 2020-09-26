<?php


namespace App\Response;


class GetHighestRatedAnimeResponse
{
    private $id;
    private $categoryName;
    private $animeName;
    private $animeMainImage;
  
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
    public function getCategoryName()
    {
        return $this->categoryName;
    }

    /**
     * @param mixed $categoryName
     */
    public function setCategoryName($categoryName)
    {
        $this->categoryName = $categoryName;
        return $this->$categoryName;
    }

    /**
     * Get the value of animeName
     */ 
    public function getAnimeName()
    {
        return $this->animeName;
    }

    /**
     * Set the value of animeName
     *
     * @return  self
     */ 
    public function setAnimeName($animeName)
    {
        $this->animeName = $animeName;

        return $this;
    }

    /**
     * Get the value of animeMainImage
     */ 
    public function getAnimeMainImage()
    {
        return $this->animeMainImage;
    }

    /**
     * Set the value of animeMainImage
     *
     * @return  self
     */ 
    public function setAnimeMainImage($animeMainImage)
    {
        $this->animeMainImage = $animeMainImage;

        return $this;
    }

}