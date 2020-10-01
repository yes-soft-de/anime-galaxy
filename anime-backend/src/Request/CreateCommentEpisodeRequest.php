<?php

namespace App\Request;

use DateTime;

class CreateCommentEpisodeRequest
{
    private $id;
    private $userID;
    private $episodeID;
    private $comment;
    private $spoilerAlert;
    private $creationDate;

    public function __construct()
    {
        $this->creationDate = new DateTime('Now');
    }

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
    public function setComment($comment): void
    {
        $this->comment = $comment;
    }

    /**
     * @return mixed
     */ 
    public function getSpoilerAlert()
    {
        return $this->spoilerAlert;
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
     * @return DateTime
     */
    public function getCreationDate(): DateTime
    {
        return $this->creationDate;
    }

    /**
     * @param DateTime $creationDate
     */
    public function setCreationDate(DateTime $creationDate): void
    {
        $this->creationDate = $creationDate;
    }


}