<?php


namespace App\Service;

use App\AutoMapping;
use App\Entity\User;
use App\Manager\AdminManager;
use App\Request\AdminCreateRequest;
use App\Response\AdminResponse;
use App\Response\AllAdminResponse;

class AdminService
{
    private $autoMapping;
    private $adminManager;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
    }

    public function adminCreate(AdminCreateRequest $request)
    {
        $adminCreate = $this->adminManager->adminCreate($request);

        return $this->autoMapping->map(User::class, AdminResponse::class, $adminCreate);
    }

    public function deleteAdmin($userID)
    {
        $adminResult = $this->adminManager->deleteAdmin($userID);

        return $this->autoMapping->map(User::class, AdminResponse::class, $adminResult);
    }

    public function getAllAdministrators()
    {
        $response = [];
        $result = $this->adminManager->getAllAdministrators();
        //dd($result);
        foreach ($result as $row)
        {
            $response[] = $this->autoMapping->map('array', AllAdminResponse::class, $row);
        }

        return $response;
    }
}
