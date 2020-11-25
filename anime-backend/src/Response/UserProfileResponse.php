<?php


namespace App\Response;


class UserProfileResponse
{
    public $id;

    public $userID;

    public $userName;

    public $location;

    public $story;

    public $image;

    public $createdAt;

    public $commentsNumber;

    public $followedByNumber;

    /**
     * @param mixed $commentsNumber
     */
    public function setCommentsNumber($commentsNumber): void
    {
        $this->commentsNumber = $commentsNumber;
    }

    /**
     * @param mixed $followedByNumber
     */
    public function setFollowedByNumber($followedByNumber): void
    {
        $this->followedByNumber = $followedByNumber;
    }

}