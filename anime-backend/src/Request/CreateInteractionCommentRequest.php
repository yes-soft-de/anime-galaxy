<?php

namespace App\Request;

use DateTime;

class CreateInteractionCommentRequest
{
    private $userID;
    private $commentID;
    private $type;
    private $creationDate;

    public function __construct()
    {
        $this->creationDate = new DateTime('Now');
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
    public function getCommentID()
    {
        return $this->commentID;
    }

    /**
     * @param mixed $commentID
     */
    public function setCommentID($commentID): void
    {
        $this->commentID = $commentID;
    }

    /**
     * @return mixed
     */ 
    public function getType()
    {
        return $this->type;
    }

    /**
     * @param mixed $type
     */
    public function setType($type): void
    {
        $this->type = $type;
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