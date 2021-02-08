<?php

namespace App\Controller;

use App\AutoMapping;
use App\Entity\ResetPasswordRequest;
use App\Entity\User;
use App\Request\CreateAskResetPasswordRequest;
use App\Request\UpdatePasswordRequest;
use App\Request\UserProfileCreateRequest;
use App\Request\UserProfileUpdateRequest;
use App\Request\UserRegisterRequest;
use App\Service\UserService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Csrf\TokenGenerator\TokenGeneratorInterface;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class UserController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $userService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, UserService $userService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->userService = $userService;
    }

    /**
     * @Route("/user", name="userRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UserRegisterRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->userRegister($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/userprofile", name="userProfileCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userProfileCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UserProfileCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->userService->userProfileCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/userprofile", name="updateUserProfile", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function updateUserProfile(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UserProfileUpdateRequest::class,(object)$data);

        $response = $this->userService->userProfileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/userprofile/{id}", name="getUserProfileByID",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getUserProfileByID(Request $request)
    {
        $response = $this->userService->getUserProfileByUserID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/userprofileall", name="userProfileAll",methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function userProfileAll(Request $request)
    {
        $response = $this->userService->getAllProfiles();

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("allprofiles", name="deleteAllProfiles", methods={"DELETE"})
     */
    public function deleteAllProfiles()
    {
        $response = $this->userService->deleteAllProfiles();

        return $this->json('Number of profiles deleted: ' . $response);
    }

    /**
     * @Route("/askresetpassword", name="app_forgotten_password", methods={"POST"})
     * @param Request $request
     * @param MailerInterface $mailer
     * @return JsonResponse
     */
    public function askResetPassword(Request $request, MailerInterface $mailer)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,CreateAskResetPasswordRequest::class, (object)$data);

        $response = $this->userService->askResetPassword($request, $mailer);

        return $this->response($response, self::CREATE);

    }

    /**
     * @Route("/reset-password", name="app_reset_password", methods={"POST"})
     * @param Request $request
     * @param UserPasswordEncoderInterface $passwordEncoder
     */
    public function resetPassword(Request $request, UserPasswordEncoderInterface $passwordEncoder)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,UpdatePasswordRequest::class, (object)$data);

        $response = $this->userService->resetPassword($request, $passwordEncoder);

        return $this->response($response, self::UPDATE);

    }

    /**
     * @Route("/usersall", name="getAllUsers", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getUserAll(Request $request)
    {
        $response = $this->userService->getAllUsers();

        return $this->response($response,self::FETCH);
    }
}
