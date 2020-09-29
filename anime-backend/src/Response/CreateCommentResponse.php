<?php

namespace App\Response;

class CreateCommentResponse
{
    public $id;
    public $userID;
    public $animeID;
    public $comment;
    public $spoilerAlert;
    public $creationDate;

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
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @return mixed
     */
    public function getAnimeID()
    {
        return $this->animeID;
    }

    /**
     * @param mixed $animeID
     */
    public function setAnimeID($animeID): void
    {
        $this->animeID = $animeID;
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
    public function setComment($comment): void
    {
        $this->comment = $comment;
    }


   /**
     * @param mixed $spoilerAlert
     */ 
    public function setSpoilerAlert($spoilerAlert)
    {
        $this->spoilerAlert = $spoilerAlert;

        return $this;
    }

      /**
     * @return mixed
     */
    public function getSpoilerAlert()
    {
        return $this->spoilerAlert;
    }

    /**
     * @return mixed
     */ 
    public function getCreationDate()
    {
        return $this->creationDate;
    }

    /**
     * @param mixed $creationDate
     */ 
    public function setCreationDate($creationDate): void
    {
        $this->creationDate = $creationDate;
    }
}