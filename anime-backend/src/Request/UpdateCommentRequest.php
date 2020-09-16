<?php

namespace App\Request;

class UpdateCommentRequest
{
    private $id;
    private $userID;
    private $animeID;
    private $comment;

     /**
     * @return mixed
     */
    public function getId(): ?int
    {
        return $this->id;
    }

     /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

   /**
     * @return mixed
     */ 
    public function getUserId()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserId($userID)
    {
        $this->userID = $userID;

        return $this;
    }

    /**
     * @return mixed
     */  
    public function getAnimeId()
    {
        return $this->animeID;
    }

    /**
     * @param mixed $animeID
     */
    public function setAnimeId($animeID)
    {
        $this->animeID = $animeID;

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