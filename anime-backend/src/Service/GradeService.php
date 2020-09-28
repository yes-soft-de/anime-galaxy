<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\Grade;
use App\Manager\GradeManager;
use App\Response\CreateGradeResponse;
use App\Response\GetGradeByIdResponse;
use App\Response\GetGradeByUserIdResponse;
use App\Response\GetGradeResponse;
use App\Response\UpdateGradeResponse;

class GradeService
{
    private $gradeManager;
    private $autoMapping;

    public function __construct(GradeManager $gradeManager, AutoMapping $autoMapping)
    {
        $this->gradeManager = $gradeManager;
        $this->autoMapping = $autoMapping;
    }

    public function create($request)
    {
        $gradeResult = $this->gradeManager->create($request);

        return $this->autoMapping->map(Grade::class, CreateGradeResponse::class, $gradeResult);
    }

    public function getUsersByPoints($request)
    {
        $response = [];
        $result = $this->gradeManager->getUsersByPoints($request);

        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', GetGradeResponse::class, $row);
        }

        return $response;
    }

    public function getGradeByUserId($request)
    {
        $result = $this->gradeManager->getGradeByUserId($request);

        return $this->autoMapping->map(Grade::class, GetGradeByUserIdResponse::class, $result);
    }

    public function update($request)
    {
        $gradeResult = $this->gradeManager->update($request);
        $response = $this->autoMapping->map(Grade::class, UpdateGradeResponse::class, $gradeResult);

        $response->setPoints($request->getPoints());

        return $response;
    }

    public function delete($request)
    {
        $gradeResult = $this->gradeManager->delete($request);
        
        if($gradeResult == null)
        {
            return null;
        }

        return $this->autoMapping->map(Grade::class, GetGradeByIdResponse::class, $gradeResult);
    }
}