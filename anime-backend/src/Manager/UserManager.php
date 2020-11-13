<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\User;
use App\Entity\UserProfile;
use App\Repository\UserProfileRepository;
use App\Repository\UserRepository;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;
    private $userProfileRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                UserPasswordEncoderInterface $encoder, UserRepository $userRepository, UserProfileRepository $userProfileRepository )
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->userProfileRepository = $userProfileRepository;
    }

    public function userRegister(UserRegisterRequest $request)
    {
        $userRegister = $this->autoMapping->map(UserRegisterRequest::class, User::class, $request);

        $user = new User($request->getUserID());

        if ($request->getPassword())
        {
            $userRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        if ($request->getRoles() == null)
        {
            $request->setRoles(['user']);
        }
        $userRegister->setRoles($request->getRoles());

        $this->entityManager->persist($userRegister);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userRegister;
    }

    public function userProfileCreate(UserProfileCreateRequest $request)
    {
        $userProfile = $this->autoMapping->map(UserProfileCreateRequest::class, UserProfile::class, $request);

        $this->entityManager->persist($userProfile);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userProfile;
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userProfileRepository->getUserProfile($request->getUserID());

        if ($item)
        {
            $item = $this->autoMapping->mapToObject(UserProfileUpdateRequest::class,
                UserProfile::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getProfileByUserID($userID)
    {
        return $this->userProfileRepository->getProfileByUSerID($userID);
    }

    public function getAllProfiles()
    {
        return $this->userProfileRepository->getAllProfiles();
    }


}