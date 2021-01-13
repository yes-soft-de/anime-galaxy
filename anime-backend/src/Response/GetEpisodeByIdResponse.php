<?php


namespace App\Response;


class GetEpisodeByIdResponse
{
    public $animeName;
    public $seasonNumber;
    public $episodeNumber;
    public $description;
    public $image;
    public $duration;
    public $publishDate;
    public $createdAt;
    public $comments;
    public $interactions;
    public $rating;
    public $categories = [];
    public $animePublishDate;
    public $imageURL;
    public $baseURL;
    public $animeID;
//    public $categoryID;
    public $posterImage;
    public $posterImageURL;

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

}