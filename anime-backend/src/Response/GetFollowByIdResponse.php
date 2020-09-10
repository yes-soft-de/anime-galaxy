<?php


namespace App\Response;


class GetFollowByIdResponse
{
    private $userID;
    private $friendID;

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
    public function getFriendID()
    {
        return $this->friendID;
    }

    /**
     * @param mixed $friendID
     */
    public function setFriendID($friendID): void
    {
        $this->friendID = $friendID;
    }


}