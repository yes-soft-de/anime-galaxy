<?php

namespace App\Response;

class GetCommentsResponse
{
    
    private $comment;
    private $solar;
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
    public function getSolar()
    {
        return $this->solar;
    }

   /**
     * @param mixed $solar
     */ 
    public function setSolar($solar)
    {
        $this->solar = $solar;

        return $this;
    }
}