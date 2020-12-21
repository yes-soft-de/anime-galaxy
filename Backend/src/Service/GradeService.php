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

    public function getTopUsers()
    {
        $response = [];
        $result = $this->gradeManager->getTopUsers();

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
        if($request->getRequestSender() == "like")
        {
            $request->setPoints(1);
        }
        elseif ($request->getRequestSender() == "comment")
        {
            $request->setPoints(2);
        }
        elseif ($request->getRequestSender() == "favourite")
        {
            $request->setPoints(3);
        }
        elseif ($request->getRequestSender() == "rating")
        {
            $request->setPoints(4);
        }

        $gradeResult = $this->gradeManager->update($request);
        return $this->autoMapping->map(Grade::class, UpdateGradeResponse::class, $gradeResult);

//        $response->setPoints($request->getPoints());
//        $response->setUserID($request->getUserID());
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