<?php


namespace App\Request;


class CreateSuperAdminRequest
{
    private $userID;

    private $roles = [];

    private $password;

    public function __construct()
    {
        $this->roles = 'ROLE_SUPER_ADMIN';
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @param mixed $password
     */
    public function setPassword($password): void
    {
        $this->password = $password;
    }

}