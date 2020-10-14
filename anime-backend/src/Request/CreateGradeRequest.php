<?php


namespace App\Request;


class CreateGradeRequest
{
    private $userID;
    private $points;

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @param mixed $points
     */
    public function setPoints($points): void
    {
        $this->points = $points;
    }
}