<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\User;
use App\Entity\UserProfile;
use App\Manager\UserManager;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use phpDocumentor\Reflection\Types\Array_;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class UserService
{
    private $autoMapping;
    private $userManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->params = $params->get('upload_base_url').'/';
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->userManager->userRegister($request);

        return $this->autoMapping->map(User::class,UserRegisterResponse::class, $userRegister);
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->userManager->userProfileCreate($request);

        if($userProfile instanceof UserProfile)
        {
            return $this->autoMapping->map(UserProfile::class, UserProfileCreateResponse::class, $userProfile);
        }
        else if($userProfile == 1)
        {
            return $this->getUserProfileByUserID($request->getUserID());
        }
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userManager->userProfileUpdate($request);

        return $this->autoMapping->map(UserProfile::class,UserProfileResponse::class, $item);
    }

    public function getUserProfileByUserID($userID)
    {
        $item = $this->userManager->getProfileByUserID($userID);

        if(isset($item['image']))
        {
            $item['image'] = $this->params . $item['image'];
        }

        return $this->autoMapping->map('array', UserProfileResponse::class, $item);
    }

    public function getAllProfiles()
    {
        $response = [];
        $result = $this->userManager->getAllProfiles();

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map(UserProfile::class, UserProfileResponse::class, $row);
        }
        return $response;
    }

    public function deleteAllProfiles()
    {
        return $this->userManager->deleteAllProfiles();
    }
}