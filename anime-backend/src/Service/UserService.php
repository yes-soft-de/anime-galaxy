<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\User;
use App\Entity\UserProfile;
use App\Manager\UserManager;
use App\Request\CreateAskResetPasswordRequest;
use App\Request\UpdatePasswordRequest;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Response\UserProfileCreateResponse;
use App\Response\UserProfileResponse;
use App\Response\UserRegisterResponse;
use phpDocumentor\Reflection\Types\Array_;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class UserService implements UserServiceInterface
{
    private $autoMapping;
    private $userManager;
    private $params;
    private $commentService;
    private $followService;

    public function __construct(AutoMapping $autoMapping, UserManager $userManager, ParameterBagInterface $params,
 CommentService $commentService, FollowService $followService)
    {
        $this->autoMapping = $autoMapping;
        $this->userManager = $userManager;
        $this->commentService = $commentService;
        $this->followService = $followService;

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

        $item->setImage($this->params . $item->getImage());
        $item->setCover($this->params . $item->getCover());

        return $this->autoMapping->map(UserProfile::class,UserProfileResponse::class, $item);
    }

    public function getUserProfileByUserID($userID)
    {
        $item = $this->userManager->getProfileByUserID($userID);
        $commentsNumber = $this->commentService->commentsNumber($userID);
        $followedByNumber = $this->followService->getFollowedByNumber($userID);

        if(isset($item['image']))
        {
            $item['image'] = $this->params . $item['image'];
        }
        if(isset($item['cover']))
        {
            $item['cover'] = $this->params . $item['cover'];
        }

        $response = $this->autoMapping->map('array', UserProfileResponse::class, $item);

        $response->setCommentsNumber($commentsNumber->getCommentsNumber());
        $response->setFollowedByNumber($followedByNumber);

        return $response;
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

    public function askResetPassword(CreateAskResetPasswordRequest $request, MailerInterface $mailer)
    {
        return $this->userManager->askResetPassword($request, $mailer);
    }

    public function resetPassword(UpdatePasswordRequest $request, UserPasswordEncoderInterface $encoder)
    {
        return $this->userManager->resetPassword($request, $encoder);
    }
    
    public function getAllUsers()
    {
        return $this->userManager->getAllUsers();
    }
}