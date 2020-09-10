<?php


namespace App\Controller;


use App\AutoMapping;
use App\Request\CreateFollowRequest;
use App\Request\DeleteRequest;
use App\Request\GetByIdRequest;
use App\Service\FollowService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class FollowController extends BaseController
{
    private $followService;
    private $autoMapping;

    /**
     * FollowController constructor.
     * @param FollowService $followService
     * @param AutoMapping $autoMapping
     */
    public function __construct(FollowService $followService, AutoMapping $autoMapping)
    {
        $this->followService = $followService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/following", name="createFollowing", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function create(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $request = $this->autoMapping->map(\stdClass::class, CreateFollowRequest::class, (object) $data);
        $result = $this->followService->create($request);
        return $this->response($result, self::CREATE);
    }

    /**
     * @Route("/following", name="getAllFollowing", methods={"GET"})
     */
    public function getAll()
    {
        $result = $this->followService->getAll();
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/following/{id}", name="getFollowingById", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function getById(Request $request)
    {
        $request=new GetByIdRequest($request->get('id'));
        $result = $this->followService->getFollowById($request);
        return $this->response($result, self::FETCH);
    }

    /**
     * @Route("/following/{id}", name="deleteFollowing", methods={"DELETE"})
     * @param Request $request
     * @return JsonResponse
     */
    public function delete(Request $request)
    {
        $request = new DeleteRequest($request->get('id'));
        $result = $this->followService->delete($request);

        return $this->response(" ", self::DELETE);
    }

    /**
     * @Route("/following/{userID}/{friendID}")
     */
    public function deleteByUserIdAndFriendId()
    {}
}