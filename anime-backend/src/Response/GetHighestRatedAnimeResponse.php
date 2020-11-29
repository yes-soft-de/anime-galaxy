<?php


namespace App\Response;


class GetHighestRatedAnimeResponse
{
    public $id;
	public $animeName;
    public $categoryID;
    public $categoryName;
    public $animeMainImage;
    //public $rating;
  
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
    public function setCategoryName($categoryName): void
    {
        $this->categoryName = $categoryName;
    }

    /**
     * @return mixed
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
     * @return mixed
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