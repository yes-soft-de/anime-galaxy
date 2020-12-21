<?php


namespace App\Response;


class GetHighestRatedAnimeByUserResponse
{
    public $id;
    public $animeName;
    public $animeMainImage;
    public $rating;    
    public $categoryName;    
    public $categoryID;    


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
     * Get the value of animeName
     */ 
    public function getAnimeName()
    {
        return $this->animeName;
    }

    /**
     * @param mixed $animeName
     */
    public function setAnimeName($animeName): void
    {
        $this->animeName = $animeName;
    }

    /**
     * Get the value of animeMainImage
     */ 
    public function getAnimeMainImage()
    {
        return $this->animeMainImage;
    }

    /**
     * @param mixed $animeMainImage
     */
    public function setAnimeMainImage($animeMainImage): void
    {
        $this->animeMainImage = $animeMainImage;
    }

}