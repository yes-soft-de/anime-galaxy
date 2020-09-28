<?php


namespace App\Request;


class GetByPointsRequest
{
    private $points;

    /**
     * GetByPointsRequest constructor.
     * @param $points
     */
    public function __construct($points)
    {
        $this->points = $points;
    }

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