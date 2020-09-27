<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\Grade;
use App\Repository\GradeRepository;
use App\Request\CreateGradeRequest;
use App\Request\DeleteRequest;
use App\Request\GetByPointsRequest;
use App\Request\UpdateGradeRequest;
use Doctrine\ORM\EntityManagerInterface;

class GradeManager
{
    private $entityManager;
    private $gradeRepository;
    private $autoMapping;

    public function __construct(EntityManagerInterface $entityManager, GradeRepository $gradeRepository,
                                AutoMapping $autoMapping)
    {
        $this->entityManager = $entityManager;
        $this->gradeRepository = $gradeRepository;
        $this->autoMapping = $autoMapping;
    }

    public function create(CreateGradeRequest $request)
    {
        $gradeEntity = $this->autoMapping->map(CreateGradeRequest::class, Grade::class, $request);

        $this->entityManager->persist($gradeEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $gradeEntity;
    }

    public function update(UpdateGradeRequest $request)
    {
        $gradeEntity = $this->gradeRepository->getGradeByUserId($request->getUserID());

        if(!$gradeEntity)
        {
            //return null;
        }
        else
        {
            $gradeEntity = $this->autoMapping->mapToObject(UpdateGradeRequest::class,
                Grade::class, $request, $gradeEntity);

            $this->entityManager->flush();

            return $gradeEntity;
        }
    }

    public function getUsersByPoints(GetByPointsRequest $request)
    {
        return $this->gradeRepository->getUsersByPoints($request->getPoints());
    }

    public function getGradeByUserId($userID)
    {
        return $this->gradeRepository->getGradeByUserId($userID);
    }

    public function delete(DeleteRequest $request)
    {
        $grade = $this->gradeRepository->getGradeById($request->getId());

        if(!$grade)
        {
            return null;
        }
        else
        {
            $this->entityManager->remove($grade);
            $this->entityManager->flush();
        }

        return $grade;
    }
}