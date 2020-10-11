<?php

namespace App\Response;

class GetCommentEpisodeByIdResponse
{
    public $id;
    public $userID;
    public $episodeID;
    public $comment;
    public $spoilerAlert;
    public $interactions;
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
    public function getEpisodeID()
    {
        return $this->episodeID;
    }

    /**
     * @param mixed $episodeID
     */
    public function setEpisodeID($episodeID): void
    {
        $this->episodeID = $episodeID;
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

    /**
     * Get the value of spoilerAlert
     */ 
    public function getSpoilerAlert()
    {
        return $this->spoilerAlert;
    }

    /**
     * Set the value of spoilerAlert
     *
     * @return  self
     */ 
    public function setSpoilerAlert($spoilerAlert)
    {
        $this->spoilerAlert = $spoilerAlert;

        return $this;
    }
}