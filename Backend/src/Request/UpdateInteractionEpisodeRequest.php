<?php

namespace App\Request;

class UpdateInteractionEpisodeRequest
{
    private $id;
    private $userID;
    private $episodeID;
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