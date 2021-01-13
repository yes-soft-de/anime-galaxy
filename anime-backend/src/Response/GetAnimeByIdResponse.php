<?php


namespace App\Response;


class GetAnimeByIdResponse
{
    public $id;
    public $name;
    public $mainImage;
    public $images;
    public $categories = [];
    public $interactions;
    public $comments;
    public $rating;
    public $description;
    public $episodesCount;
    public $trailerVideo;
    public $publishDate;
    public $imageURL;
    public $baseURL;
    public $generalRating;
    public $ageGroup;
    public $posterImage;
    public $posterImageURL;
    public $createdAt;
    public $updatedAt;
    public $updatedBy;
    public $createdBy;

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
    public function getImages()
    {
        return $this->images;
    }

    /**
     * @param mixed $images
     */
    public function setImages($images): void
    {
        $this->images = $images;
    }

//    /**
//     * @return mixed
//     */
//    public function getCategoryName(): array
//    {
//        return $this->categoryName;
//    }
//
//    /**
//     * @param mixed $categoryName
//     */
//    public function setCategoryName($categoryName): void
//    {
//        $this->categoryName = $categoryName;
//    }

    /**
     * @return mixed
     */
    public function getRating()
    {
        return $this->rating;
    }

    /**
     * @param mixed $rating
     */
    public function setRating($rating): void
    {
        $this->rating = $rating;
    }

    /**
     * @return mixed
     */
    public function getComments()
    {
        return $this->comments;
    }

    /**
     * @param mixed $comments
     */
    public function setComments($comments): void
    {
        $this->comments = $comments;
    }


}