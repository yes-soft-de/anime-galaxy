<?php

namespace App\Response;

class CountInerActionResponse
{

    public $countIneraction;
   
    /**
     * Set the value of countInerAction
     *
     * @return  self
     */ 
    public function setCountIneraction($countIneraction)
    {
        $this->countIneraction = $countIneraction;

        return $this;
    }
}