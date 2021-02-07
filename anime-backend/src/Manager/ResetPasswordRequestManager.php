<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\ResetPasswordRequest;
use App\Repository\ResetPasswordRequestRepository;
use App\Request\CreateAskResetPasswordRequest;
use Doctrine\ORM\EntityManagerInterface;

class ResetPasswordRequestManager
{
    private $entityManager;
    private $resetPasswordRequestRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManager, ResetPasswordRequestRepository $resetPasswordRequestRepository,
                                AutoMapping $autoMapping)
    {
        $this->entityManager = $entityManager;
        $this->resetPasswordRequestRepository = $resetPasswordRequestRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateAskResetPasswordRequest $request)
    {
        $resetPasswordRequestEntity = $this->autoMapping->map(CreateAskResetPasswordRequest::class, ResetPasswordRequest::class, $request);
        $this->entityManager->persist($resetPasswordRequestEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();
        return $resetPasswordRequestEntity;
    }

    public function checkResetRequest($email, $code)
    {
        return $this->resetPasswordRequestRepository->getResetPasswordRequestByEmailAndCode($email, $code);
    }
}