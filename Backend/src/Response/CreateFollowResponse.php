<?php


namespace App\Response;


class CreateFollowResponse
{
    public $id;
    public $userID;
    public $friendID;

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