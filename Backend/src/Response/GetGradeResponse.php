<?php


namespace App\Response;


class GetGradeResponse
{
    public $userID;
    public $points;
    public $username;
    public $image;

    /**
     * @return mixed
     */
    public function getPoints()
    {
        return $this->points;
    }

    /**
     * @param mixed $points
     */
    public function setPoints($points): void
    {
        $this->points = $points;
    }

}