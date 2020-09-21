<?php

namespace App\Response;

class GetCommentsResponse
{
    //private $animeID;
    private $comment;

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
}