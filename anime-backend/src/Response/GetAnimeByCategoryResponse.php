<?php


namespace App\Response;


class GetAnimeByCategoryResponse
{
    public $name;
    public $mainImage;
    public $countInteraction;
    public $rating;
    public $comment;

    

   

    /**
     * Set the value of name
     *
     * @return  self
     */ 
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Set the value of mainImage
     *
     * @return  self
     */ 
    public function setMainImage($mainImage)
    {
        $this->mainImage = $mainImage;

        return $this;
    }

    /**
     * Set the value of countInteraction
     *
     * @return  self
     */ 
    public function setCountInteraction($countInteraction)
    {
        $this->countInteraction = $countInteraction;

        return $this;
    }

    /**
     * Set the value of rating
     *
     * @return  self
     */ 
    public function setRating($rating)
    {
        $this->rating = $rating;

        return $this;
    }

    /**
     * Set the value of comment
     *
     * @return  self
     */ 
    public function setComment($comment)
    {
        $this->comment = $comment;

        return $this;
    }
}