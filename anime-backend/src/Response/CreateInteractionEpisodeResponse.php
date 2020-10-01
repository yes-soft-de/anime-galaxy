<?php

namespace App\Response;

class CreateInteractionEpisodeResponse
{
    public $id;

    public $userID;

    public $episodeID;

    public $type;

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