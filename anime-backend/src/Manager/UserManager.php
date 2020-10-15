<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\User;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Repository\UserEntityRepository;
use App\Repository\UserProfileEntityRepository;
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

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                UserPasswordEncoderInterface $encoder, UserRepository $userRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
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
        $userProfile = $this->autoMapping->map(UserProfileCreateRequest::class, UserProfileEntity::class, $request);

        $this->entityManager->persist($userProfile);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $userProfile;
    }

    public function userProfileUpdate(UserProfileUpdateRequest $request)
    {
        $item = $this->userProfileEntityRepository->getProfileByUSerID($request->getUserID());

        if ($item)
        {
            $item = $this->autoMapping->mapToObject(UserProfileUpdateRequest::class,
                UserProfileEntity::class, $request, $item);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $item;
        }
    }

    public function getProfileByUserID($userID)
    {
        return $this->userProfileEntityRepository->getProfileByUSerID($userID);
    }
}