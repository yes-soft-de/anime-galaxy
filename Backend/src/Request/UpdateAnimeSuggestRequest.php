<?php


namespace App\Request;


class UpdateAnimeSuggestRequest
{
    private $id;
    private $suggest;

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
     * @param mixed $suggest
     */
    public function setSuggest($suggest): void
    {
        $this->suggest = $suggest;
    }


}