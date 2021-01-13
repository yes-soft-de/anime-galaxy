<?php

namespace App\Service;

use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;

interface UserServiceInterface
{
    public function userRegister(UserRegisterRequest $request);
    public function userProfileCreate(UserProfileCreateRequest $request);
    public function userProfileUpdate(UserProfileUpdateRequest $request);
    public function getUserProfileByUserID($userID);
    public function getAllProfiles();
    public function deleteAllProfiles();
}