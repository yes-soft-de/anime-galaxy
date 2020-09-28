<?php

namespace App\Response;

class GetCommentsResponse
{
    
    public $comment;
    public $spoilerAlert;
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
}