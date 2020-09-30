<?php


namespace App\Controller;

use App\AutoMapping;
use App\Request\CreateGradeRequest;
use App\Request\DeleteRequest;
use App\Request\UpdateGradeRequest;
use App\Service\GradeService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class GradeController extends BaseController
{
    private $gradeService;
    private $autoMapping;

    public function __construct(SerializerInterface $serializer, GradeService $gradeService, AutoMapping $autoMapping)
    {
        parent::__construct($serializer);
        $this->gradeService = $gradeService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/register-point", name="createNewGrade", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateGradeRequest::class, (object)$data);

        $request->setPoints(0);

        $result = $this->gradeService->create($request);

        return $this->response($result,self::CREATE);
    }

    /**
     * @Route("/grade", name="updateGrade", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, UpdateGradeRequest::class, (object)$data);

        $result = $this->gradeService->update($request);

        return $this->response($result, self::UPDATE);
    }

    /**
     * @Route("/top50", name="getTopUsers", methods={"GET"})
     * @return JsonResponse
     */
    public function getTopUsers()
    {
        $result = $this->gradeService->getTopUsers();

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/grade/{userID}", name="getUserGrade", methods={"GET"})
     * @param $userID
     * @return JsonResponse
     */
    public function getUserGrade($userID)
    {
        $result = $this->gradeService->getGradeByUserId($userID);

        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/grade/{id}", name="deleteGrade", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->gradeService->delete($request);

        return $this->response("",self::DELETE);
    }
}