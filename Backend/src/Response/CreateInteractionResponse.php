<?php

namespace App\Response;

class CreateInteractionResponse
{
    public $id;

    public $userID;

    public $animeID;

    public $type;

    public $creationDate;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @return mixed
     */
    public function getType()
    {
        return $this->type;
    }

}