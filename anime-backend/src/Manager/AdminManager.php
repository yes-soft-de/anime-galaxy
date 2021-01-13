<?php


namespace App\Manager;

use App\AutoMapping;
use App\Entity\User;
use App\Entity\UserProfile;
use App\Repository\UserProfileRepository;
use App\Repository\UserRepository;
use App\Request\AdminCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class AdminManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;
    private $userProfileRepository;

    public function __construct(
        AutoMapping $autoMapping,
        EntityManagerInterface $entityManager,
        UserPasswordEncoderInterface $encoder,
        UserRepository $userRepository,
        UserProfileRepository $userProfileRepository
    ) {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->userProfileRepository = $userProfileRepository;
    }

    public function adminCreate($request)
    {
        $adminCreate = $this->autoMapping->map(AdminCreateRequest::class, User::class, $request);

        $user = new User($request->getUserID());

        if ($request->getPassword()) {
            $adminCreate->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        if ($request->getRoles() == null) {
            $request->setRoles(['ROLE_ADMIN']);
        }
        $adminCreate->setRoles($request->getRoles());

        $this->entityManager->persist($adminCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        // Create new profile

        $adminProfile = $this->userProfileRepository->findOneBy(["userID"=>$request->getUserID()]);

        if(!$adminProfile)
        {
            $userProfile = $this->autoMapping->map(AdminCreateRequest::class, UserProfile::class, $request);

            $this->entityManager->persist($userProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();
        }

        return $adminCreate;
    }

    public function deleteAdmin($userID)
    {
        // Remove the profile of the admin first

        $adminProfile = $this->userProfileRepository->findOneBy(["userID"=>$userID]);

        if($adminProfile)
        {
            $this->entityManager->remove($adminProfile);
            $this->entityManager->flush();
        }

        // Remove admin record in the User entity

        $adminData = $this->userRepository->getUserByUserID($userID);

        if($adminData)
        {
            $this->entityManager->remove($adminData);
            $this->entityManager->flush();
        }

        return $adminData;
    }
}
