<?php


namespace App\Request;


class UpdateGradeRequest
{
    private $userID;
    private $points;
    /**
     * @var $requestSender
     * holds string refers to the caller of the update request
     * "comment" refers to commentService
     */
    private $requestSender;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
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

    /**
     * @return mixed
     */
    public function getRequestSender()
    {
        return $this->requestSender;
    }

    /**
     * @param mixed $requestSender
     */
    public function setRequestSender($requestSender): void
    {
        $this->requestSender = $requestSender;
    }

}