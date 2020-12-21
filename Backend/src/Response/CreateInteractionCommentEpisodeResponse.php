<?php

namespace App\Response;

class CreateInteractionCommentEpisodeResponse
{
    public $id;

    public $userID;

    public $commentID;

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