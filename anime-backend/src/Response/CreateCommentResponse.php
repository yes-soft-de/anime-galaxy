<?php

namespace App\Response;

class CreateCommentResponse
{
    public $id;
    public $userId;
    public $animeId;
    public $comment;

     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
    }
    

   /**
     * @return mixed
     */ 
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * @param mixed $userId
     */
    public function setUserId($userId)
    {
        $this->userId = $userId;

        return $this;
    }

    /**
     * @return mixed
     */  
    public function getAnimeId()
    {
        return $this->animeId;
    }

    /**
     * @param mixed $animeId
     */
    public function setAnimeId($animeId)
    {
        $this->animeId = $animeId;

        return $this;
    }

    /**
     * @return mixed
     */ 
    public function getComment()
    {
        return $this->comment;
    }

   /**
     * @param mixed $comment
     */
    public function setComment($comment)
    {
        $this->comment = $comment;

        return $this;
    }
}