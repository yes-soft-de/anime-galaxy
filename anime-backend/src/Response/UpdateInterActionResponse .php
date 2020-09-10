<?php

namespace App\Response;

class UpdateInterActionResponse  
{
    private $id;
    private $userId;
    private $animeId;
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
    public function getType()
    {
        return $this->type;
    }

   /**
     * @param mixed $type
     */
    public function setType($type)
    {
        $this->type = $type;

        return $this;
    }
}