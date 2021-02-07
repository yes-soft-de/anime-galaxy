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
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class UserManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;
    private $userProfileRepository;
    private $resetPasswordManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder,
                                UserRepository $userRepository, UserProfileRepository $userProfileRepository, ResetPasswordRequestManager $resetPasswordRequestManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->userProfileRepository = $userProfileRepository;
        $this->resetPasswordManager = $resetPasswordRequestManager;
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
        $userProfile = $this->getProfileByUserID($request->getUserID());
        //dd($userProfile);
        if($userProfile == null)
        {
            $userProfile = $this->autoMapping->map(UserProfileCreateRequest::class, UserProfile::class, $request);

            $this->entityManager->persist($userProfile);
            $this->entityManager->flush();
            $this->entityManager->clear();

            return $userProfile;
        }
        else
        {
            return 1;
        }
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

    public function deleteAllProfiles()
    {
        $res = $this->userProfileRepository->deleteAllProfiles();

        $this->entityManager->flush();
        $this->entityManager->clear();

        return $res;
    }

    public function askResetPassword($request, $mailer)
    {
        $user = $this->userRepository->getUserByEmail($request->getEmail());

        if($user != null)
        {
            $code = $this->resetCode();

            $request->setCode($code);
            $request->setExpiresAt(new \DateTime('+1 hour'));
            
            $this->resetPasswordManager->create($request);

            $message = (new Email())
                ->from('auto-reply@animegalaxy.com')
                ->to($user->getEmail())
                ->subject("Reset Password Code")
                ->text($code)
            ;

            $mailer->send($message);

            return "Your request was being registered. And an email was being sent to you";
        }
    }

    public function resetPassword($request, $encoder)
    {
        $result = $this->resetPasswordManager->checkResetRequest($request->getEmail(), $request->getcode());

        $currentDate = new \DateTime('Now');

        if($currentDate < $result->getExpiresAt())
        {
            if($result != null)
            {
                $user = $this->userRepository->getUserByEmail($request->getEmail());

                if($user != null)
                {
                    $user->setPassword($encoder->encodePassword($user, $request->getPassword()));

                    $this->entityManager->flush();

                    return "Your password was being re-set successfully.";
                }
            }

            return $result;
        }
        else
        {
            return "The entered code expired!";
        }
    }

    public function resetCode()
    {
        $data = random_int(0, 9) . random_int(0, 9) . random_int(0, 9) . random_int(0, 9);

        return  vsprintf('%s%s%s%s', str_split(($data)));
    }

}