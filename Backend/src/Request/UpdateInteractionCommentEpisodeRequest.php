<?php

namespace App\Request;

class UpdateInteractionCommentEpisodeRequest
{
    private $id;
    private $userID;
    private $commentID;
    private $type;

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

}